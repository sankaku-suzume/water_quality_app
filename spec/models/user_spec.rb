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
