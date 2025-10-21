require 'rails_helper'

RSpec.describe 'Results', type: :request do
  let!(:user) { create(:user, admin: true) }
  let!(:plant) { create(:plant) }
  let!(:sample) { create(:sample, plant: plant) }
  let!(:test_item) { create(:test_item) }
  let!(:results) { create_list(:result, 3, sample: sample, test_item: test_item) }

  describe 'GET /result' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '200ステータスが返ってくる' do
        get plant_sample_result_path(plant_id: sample.plant.id, sample_id: sample.id, id: results.first.id)
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        get plant_sample_result_path(plant_id: sample.plant.id, sample_id: sample.id, id: results.first.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST /results' do
    context 'パラメーターが正常な場合' do
      before do
        sign_in user
      end
      let!(:result_params) { attributes_for(:result, test_item_id: test_item.id) }

      it '検査項目が保存される' do
        post plant_sample_results_path(plant_id: sample.plant.id, sample_id: sample.id),
          params: { result: result_params },
          headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }
        expect(response).to have_http_status(200)
        expect(response.media_type).to eq('text/vnd.turbo-stream.html')
        expect(response.body).to include('turbo-stream')
        expect(Result.last.value.to_f).to eq(result_params[:value])
        expect(Result.count).to eq(4)
      end
    end

    context 'パラメーターが正常でない場合' do
      before do
        sign_in user
      end
      let!(:result_params) { attributes_for(:result, test_item_id: '') }

      it '新規登録画面がレンダリングされる' do
        post plant_sample_results_path(plant_id: sample.plant.id, sample_id: sample.id),
          params: { result: result_params }
        expect(response).to have_http_status(422)
        expect(response.body).to include('新規登録')
      end
    end
  end

  describe 'PUT /result' do
    before do
      sign_in user
    end

    context 'パラメーターが正常な場合' do
      let!(:result_params) { attributes_for(:result, test_item_id: test_item.id) }

      it '検査項目を変更できる' do
        put plant_sample_result_path(plant_id: sample.plant.id, sample_id: sample.id, id: results.first.id),
          params: { result: result_params },
          headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }
        expect(response).to have_http_status(200)
        expect(response.media_type).to eq('text/vnd.turbo-stream.html')
        expect(response.body).to include('turbo-stream')
        expect(results.first.reload.value).to eq(result_params[:value].to_s)
      end
    end

    context 'パラメーターが正常でない場合' do
      let!(:result_params) { attributes_for(:result, test_item_id: '') }

      it '検査項目編集画面がレンダリングされる' do
        put plant_sample_result_path(plant_id: sample.plant.id, sample_id: sample.id, id: results.first.id),
          params: { result: result_params }
        expect(response).to have_http_status(422)
        expect(response.body).to include('編集')
      end
    end
  end

  describe 'DELETE /result' do
    before do
      sign_in user
    end

    it '検査項目を削除できる' do
      delete plant_sample_result_path(plant_id: sample.plant.id, sample_id: sample.id, id: results.first.id),
        headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }
      expect(response).to have_http_status(200)
      expect(Result.count).to eq 2
    end
  end
end
