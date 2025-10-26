# == Schema Information
#
# Table name: appa_samples
#
#  id            :bigint           not null, primary key
#  inspector     :string
#  location      :string
#  remarks       :text
#  sampling_date :date             not null
#  sampling_time :time             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  plant_id      :bigint           not null
#
# Indexes
#
#  index_appa_samples_on_plant_id  (plant_id)
#
require 'rails_helper'

RSpec.describe Sample, type: :model do
  let!(:plant) { create(:plant) }

  context '採水日と採水時間が入力されている場合' do
    let!(:sample) { build(:sample, plant: plant) }

    it '検体を保存できる' do
      expect(sample).to be_valid
    end
  end

  context '採水日は入力されているが時間が入力されていない場合' do
    let!(:sample) { build(:sample, sampling_time: nil, plant: plant) }

    before do
      sample.save
    end

    it '検体を保存できない' do
      expect(sample.errors.messages[:sampling_time][0]).to eq('を入力してください')
    end
  end

  context '採水時間は入力されているが採水日が入力されていない場合' do
    let!(:sample) { build(:sample, sampling_date: nil, plant: plant) }

    before do
      sample.save
    end

    it '検体を保存できない' do
      expect(sample.errors.messages[:sampling_date][0]).to eq('を入力してください')
    end
  end

  context '採水場所が50文字以上の場合' do
    let!(:sample) { build(:sample, location: Faker::Lorem.characters(number: 51), plant: plant) }

    before do
      sample.save
    end
    it '検体を保存できない' do
      expect(sample.errors.messages[:location][0]).to eq('は50文字以内で入力してください')
    end
  end

  context '採水者が20文字以上の場合' do
    let!(:sample) { build(:sample, inspector: Faker::Lorem.characters(number: 21), plant: plant) }

    before do
      sample.save
    end
    it '検体を保存できない' do
      expect(sample.errors.messages[:inspector][0]).to eq('は20文字以内で入力してください')
    end
  end

  context '備考が400文字以上の場合' do
    let!(:sample) { build(:sample, remarks: Faker::Lorem.characters(number: 401), plant: plant) }

    before do
      sample.save
    end
    it '検体を保存できない' do
      expect(sample.errors.messages[:remarks][0]).to eq('は400文字以内で入力してください')
    end
  end
end
