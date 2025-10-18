require 'rails_helper'

RSpec.describe 'Plants', type: :request do
  let!(:user) { create(:user, admin: true) }
  let!(:plants) { create_list(:plant, 3) }

  describe 'GET /plants' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '200ステータスが返ってくる' do
        get plants_path
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        get plants_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET /plants' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it '200ステータスが返ってくる' do
        get plant_path(id: plants.first.id)
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        get plant_path(id: plants.first.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST /plants' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '事業場が保存される' do
        plant_params = attributes_for(:plant)
        post plants_path({ plant: plant_params })
        expect(response).to have_http_status(302)
        expect(Plant.last.name).to eq(plant_params[:name])
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        plant_params = attributes_for(:plant)
        post plants_path({ plant: plant_params })
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'パラメーターが正常な場合' do
      before do
        sign_in user
      end
      let!(:plant_params) { attributes_for(:plant) }

      it '事業場を保存できる' do
        post plants_path({ plant: plant_params })
        expect(response).to have_http_status(302)
        expect(Plant.last.name).to eq(plant_params[:name])
      end
    end

    context 'パラメーターが異常な場合' do
      before do
        sign_in user
      end
      let!(:plant_params) { attributes_for(:plant, name: '') }

      it '事業場編集画面がレンダリングされる' do
        post plants_path({ plant: plant_params })
        expect(response).to have_http_status(422)
        expect(response.body).to include('新しい事業場を登録')
      end
    end
  end

  describe 'PUT /plant' do
    before do
      sign_in user
    end

    context 'パラメーターが正常な場合' do
      let!(:plant_params) { attributes_for(:plant) }

      it '事業場を変更できる' do
        put plant_path(plants.first.id), params: { plant: plant_params }
        expect(response).to have_http_status(302)
        expect(Plant.first.name).to eq(plant_params[:name])
      end
    end

    context 'パラメーターが異常な場合' do
      let!(:plant_params) { attributes_for(:plant, name: '') }

      it '事業場編集画面がレンダリングされる' do
        put plant_path(plants.first.id), params: { plant: plant_params }
        expect(response).to have_http_status(422)
        expect(response.body).to include('事業場情報を編集')
      end
    end
  end

  describe 'DELETE /plant' do
    before do
      sign_in user
    end

    it '事業場を削除できる' do
      delete plant_path(plants.first.id)
      expect(response).to have_http_status(303)
      expect(response).to redirect_to(plants_path)
      expect(Plant.count).to eq 2
    end
  end
end
