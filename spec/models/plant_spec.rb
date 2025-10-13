require 'rails_helper'

RSpec.describe Plant, type: :model do
  context '名前が入力されている場合' do
    let!(:plant) { build(:plant) }

    it '事業場を保存できる' do
      expect(plant).to be_valid
    end
  end

  context '名前が入力されていない場合' do
    let!(:plant) { build(:plant, name: '') }

    before do
      plant.save
    end

    it '事業場を保存できない' do
      expect(plant.errors.messages[:name][0]).to eq('を入力してください')
    end
  end

  context '名前がユニークでない場合' do
    test = Faker::Lorem.characters(number: 10)
    let!(:first_plant) { create(:plant, name: test) }
    let!(:plant) { build(:plant, name: test) }

    before do
      plant.save
    end
    it '事業場を保存できない' do
      expect(plant.errors.messages[:name][0]).to eq('はすでに存在します')
    end
  end

  context '名前が50文字以上の場合' do
    let!(:plant) { build(:plant, name: Faker::Lorem.characters(number: 51)) }

    before do
      plant.save
    end
    it '事業場を保存できない' do
      expect(plant.errors.messages[:name][0]).to eq('は50文字以内で入力してください')
    end
  end

  context '所在地が50文字以上の場合' do
    let!(:plant) { build(:plant, location: Faker::Lorem.characters(number: 51)) }

    before do
      plant.save
    end
    it '事業場を保存できない' do
      expect(plant.errors.messages[:location][0]).to eq('は50文字以内で入力してください')
    end
  end

  context '備考が400文字以上の場合' do
    let!(:plant) { build(:plant, remarks: Faker::Lorem.characters(number: 401)) }

    before do
      plant.save
    end
    it '事業場を保存できない' do
      expect(plant.errors.messages[:remarks][0]).to eq('は400文字以内で入力してください')
    end
  end
end
