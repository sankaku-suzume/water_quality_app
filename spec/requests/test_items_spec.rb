require 'rails_helper'

RSpec.describe 'TestItems', type: :request do
  let!(:user) { create(:user, admin: true) }
  let!(:test_items) { create_list(:test_item, 3) }

  describe 'GET /test_items' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '200ステータスが返ってくる' do
        get test_items_path
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        get test_items_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST /test_items' do
    context 'パラメーターが正常な場合' do
      before do
        sign_in user
      end
      let!(:test_item_params) { attributes_for(:test_item) }

      it '検査項目が保存される' do
        post test_items_path,
          params: { test_item: test_item_params },
          headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }
        expect(response).to have_http_status(200)
        expect(response.media_type).to eq('text/vnd.turbo-stream.html')
        expect(response.body).to include('turbo-stream')
        expect(TestItem.last.name).to eq(test_item_params[:name])
        expect(TestItem.count).to eq(4)
      end
    end

    context 'パラメーターが正常でない場合' do
      before do
        sign_in user
      end
      let!(:test_item_params) { attributes_for(:test_item, name: '') }

      it '新規登録画面がレンダリングされる' do
        post test_items_path,
          params: { test_item: test_item_params }
        expect(response).to have_http_status(422)
        expect(response.body).to include('新規登録')
      end
    end
  end

  describe 'PUT /test_item' do
    before do
      sign_in user
    end

    context 'パラメーターが正常な場合' do
      let!(:test_item_params) { attributes_for(:test_item) }

      it '検査項目を変更できる' do
        put test_item_path(test_items.last),
          params: { test_item: test_item_params },
          headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }
        expect(response).to have_http_status(200)
        expect(response.media_type).to eq('text/vnd.turbo-stream.html')
        expect(response.body).to include('turbo-stream')
        expect(test_items.last.reload.name).to eq(test_item_params[:name])
      end
    end

    context 'パラメーターが正常でない場合' do
      let!(:test_item_params) { attributes_for(:test_item, name: '') }

      it '検査項目編集画面がレンダリングされる' do
        put test_item_path(test_items.last),
          params: { test_item: test_item_params }
        expect(response).to have_http_status(422)
        expect(response.body).to include('編集')
      end
    end
  end

  describe 'DELETE /test_item' do
    before do
      sign_in user
    end

    it '検査項目を削除できる' do
      delete test_item_path(test_items.first),
        headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }
      expect(response).to have_http_status(200)
      expect(TestItem.count).to eq 2
    end
  end
end
