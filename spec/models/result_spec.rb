# == Schema Information
#
# Table name: appa_results
#
#  id           :bigint           not null, primary key
#  value        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  sample_id    :bigint           not null
#  test_item_id :bigint           not null
#
# Indexes
#
#  index_appa_results_on_sample_id     (sample_id)
#  index_appa_results_on_test_item_id  (test_item_id)
#
require 'rails_helper'

RSpec.describe Result, type: :model do
  let!(:plant) { create(:plant) }
  let!(:sample) { create(:sample, plant: plant) }
  let!(:test_item) { create(:test_item) }

  context '測定値が数字の場合' do
    let!(:result) { build(:result, sample: sample, test_item: test_item) }

    it '検査結果を保存できる' do
      expect(result).to be_valid
    end
  end

  context '測定値が空の場合' do
    let!(:result) { build(:result, value: nil, sample: sample, test_item: test_item) }

    it '検査結果を保存できる' do
      expect(test_item).to be_valid
    end
  end

  context '測定値が文字列の場合' do
    let!(:result) { build(:result, value: Faker::Lorem.characters(number: 21), sample: sample, test_item: test_item) }

    before do
      result.save
    end
    it '検査結果を保存できない' do
      expect(result.errors.messages[:value][0]).to eq('は数値で入力してください')
    end
  end
end
