# == Schema Information
#
# Table name: appa_users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_appa_users_on_email                 (email) UNIQUE
#  index_appa_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  context '名前が入力されている場合' do
    let!(:user) { build(:user) }

    it 'ユーザーを保存できる' do
      expect(user).to be_valid
    end
  end

  context '名前が入力されていない場合' do
    let!(:user) { build(:user, name: '') }

    before do
      user.save
    end

    it 'ユーザーを保存できない' do
      expect(user.errors.messages[:name][0]).to eq('を入力してください')
    end
  end

  context '名前に記号がある場合' do
    let!(:user) { build(:user, name: Faker::Internet.password(min_length: 10, max_length: 20, mix_case: true, special_characters: true)) }

    before do
      user.save
    end

    it 'ユーザーを保存できない' do
      expect(user.errors.messages[:name][0]).to eq('は日本語または英数字で入力してください')
    end
  end
end
