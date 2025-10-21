require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user_admin) { create(:user, admin: true) }
  let!(:users) { create_list(:user, 3) }

  describe 'GET /users' do
    context 'ログインしている場合' do
      before do
        sign_in user_admin
      end

      it '200ステータスが返ってくる' do
        get admin_users_path
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        get admin_users_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST /users' do
    context 'パラメーターが正常な場合' do
      before do
        sign_in user_admin
      end
      let!(:user_params) { attributes_for(:user) }

      it 'ユーザーが保存される' do
        post admin_users_path,
          params: { user: user_params },
          headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }
        expect(response).to have_http_status(200)
        expect(response.media_type).to eq('text/vnd.turbo-stream.html')
        expect(response.body).to include('turbo-stream')
        expect(User.last.name).to eq(user_params[:name])
        expect(User.count).to eq(5)
      end
    end

    context 'パラメーターが正常でない場合' do
      before do
        sign_in user_admin
      end
      let!(:user_params) { attributes_for(:user, name: '') }

      it '新規登録画面がレンダリングされる' do
        post admin_users_path,
          params: { user: user_params }
        expect(response).to have_http_status(422)
        expect(response.body).to include('新規登録')
      end
    end
  end

  describe 'PUT /result' do
    before do
      sign_in user_admin
    end

    context 'パラメーターが正常な場合' do
      let!(:user_params) { attributes_for(:user) }

      it 'ユーザーを変更できる' do
        put admin_user_path(users.last),
          params: { user: user_params },
          headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }
        expect(response).to have_http_status(200)
        expect(response.media_type).to eq('text/vnd.turbo-stream.html')
        expect(response.body).to include('turbo-stream')
        expect(users.last.reload.name).to eq(user_params[:name])
      end
    end

    context 'パラメーターが正常でない場合' do
      let!(:user_params) { attributes_for(:user, name: '') }

      it 'ユーザー編集画面がレンダリングされる' do
        put admin_user_path(users.last),
          params: { user: user_params }
        expect(response).to have_http_status(422)
        expect(response.body).to include('編集')
      end
    end
  end

  describe 'DELETE /user' do
    before do
      sign_in user_admin
    end

    it 'ユーザーを削除できる' do
      delete admin_user_path(users.first),
        headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }
      expect(response).to have_http_status(200)
      expect(User.count).to eq 3
    end
  end
end
