require 'rails_helper'

RSpec.describe "Samples", type: :request do
  let!(:user) { create(:user, admin: true) }
  let!(:plant) { create(:plant) }
  let!(:samples) { create_list(:sample, 3, plant: plant) }

  describe 'GET /samples' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '200ステータスが返ってくる' do
        get samples_path
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        get samples_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET /sample' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it '200ステータスが返ってくる' do
        get plant_sample_path(plant_id: plant.id, id: samples.first.id)
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        get plant_sample_path(plant_id: plant.id, id: samples.first.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST /samples' do
    context 'ログインしていてパラメーターが正常な場合' do
      before do
        sign_in user
      end
      let!(:sample_params) { attributes_for(:sample) }

      it '検体が保存される' do
        post plant_samples_path(plant_id: plant.id, sample: sample_params)
        expect(response).to have_http_status(302)
        expect(Sample.last.sampling_date).to eq(sample_params[:sampling_date])
        expect(Sample.last.sampling_time.strftime('%H:%M')).to eq(sample_params[:sampling_time].strftime('%H:%M'))
      end
    end

    context 'ログインしていない場合' do
      let!(:sample_params) { attributes_for(:sample) }

      it 'ログイン画面に遷移する' do
        post plant_samples_path(plant_id: plant.id, sample: sample_params)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'パラメーターが異常な場合' do
      before do
        sign_in user
      end
      let!(:sample_params) { attributes_for(:sample, sampling_date: '') }

      it '検体データ新規登録がレンダリングされる' do
        post plant_samples_path(plant_id: plant.id, sample: sample_params)
        expect(response).to have_http_status(422)
        expect(response.body).to include('検体データ 新規登録')
      end
    end
  end

  describe 'PUT /sample' do
    before do
      sign_in user
    end

    context 'パラメーターが正常な場合' do
      let!(:sample_params) { attributes_for(:sample) }

      it '事業場を変更できる' do
        put plant_sample_path(plant_id: plant.id, id: samples.first.id, sample: sample_params)
        expect(response).to have_http_status(302)
        expect(Sample.first.sampling_date).to eq(sample_params[:sampling_date])
        expect(Sample.first.sampling_time.strftime('%H:%M')).to eq(sample_params[:sampling_time].strftime('%H:%M'))
      end
    end

    context 'パラメーターが異常な場合' do
      let!(:sample_params) { attributes_for(:sample, sampling_date: '') }

      it '検体データ編集画面がレンダリングされる' do
        put plant_sample_path(plant_id: plant.id, id: samples.first.id, sample: sample_params)
        expect(response).to have_http_status(422)
        expect(response.body).to include('検体データ 編集')
      end
    end
  end

  describe 'DELETE /sample' do
    before do
      sign_in user
    end

    it '検体データを削除できる' do
      delete plant_sample_path(plant_id: plant.id, id: samples.first.id)
      expect(response).to have_http_status(303)
      expect(response).to redirect_to(plant_path(id: plant.id))
      expect(plant.samples.count).to eq 2
    end
  end
end
