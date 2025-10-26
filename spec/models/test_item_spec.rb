# == Schema Information
#
# Table name: appa_test_items
#
#  id              :bigint           not null, primary key
#  detection_limit :float
#  name            :string           not null
#  sort_order      :integer
#  standard_max    :float
#  standard_min    :float
#  unit            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe TestItem, type: :model do
  context '名前が入力されている場合' do
    let!(:test_item) { build(:test_item) }

    it '検査項目を保存できる' do
      expect(test_item).to be_valid
    end
  end

  context '名前が入力されていない場合' do
    let!(:test_item) { build(:test_item, name: '') }

    before do
      test_item.save
    end

    it '検査項目を保存できない' do
      expect(test_item.errors.messages[:name][0]).to eq('を入力してください')
    end
  end

  context '名前が20文字以上の場合' do
    let!(:test_item) { build(:test_item, name: Faker::Lorem.characters(number: 21)) }

    before do
      test_item.save
    end
    it '検査項目を保存できない' do
      expect(test_item.errors.messages[:name][0]).to eq('は20文字以内で入力してください')
    end
  end

  context '基準上限が数字の場合' do
    let!(:test_item) { build(:test_item, standard_max: Faker::Number.decimal(l_digits: 2)) }

    it '検査項目を保存できる' do
      expect(test_item).to be_valid
    end
  end

  context '基準上限が空の場合' do
    let!(:test_item) { build(:test_item, standard_max: nil) }

    it '検査項目を保存できる' do
      expect(test_item).to be_valid
    end
  end

  context '基準上限が文字列の場合' do
    let!(:test_item) { build(:test_item, standard_max: Faker::Lorem.characters(number: 21)) }

    before do
      test_item.save
    end
    it '検査項目を保存できない' do
      expect(test_item.errors.messages[:standard_max][0]).to eq('は数値で入力してください')
    end
  end

  context '基準下限が数字の場合' do
    let!(:test_item) { build(:test_item, standard_min: Faker::Number.decimal(l_digits: 2)) }

    it '検査項目を保存できる' do
      expect(test_item).to be_valid
    end
  end

  context '基準下限が空の場合' do
    let!(:test_item) { build(:test_item, standard_min: nil) }

    it '検査項目を保存できる' do
      expect(test_item).to be_valid
    end
  end

  context '基準下限が文字列の場合' do
    let!(:test_item) { build(:test_item, standard_min: Faker::Lorem.characters(number: 21)) }

    before do
      test_item.save
    end
    it '検査項目を保存できない' do
      expect(test_item.errors.messages[:standard_min][0]).to eq('は数値で入力してください')
    end
  end

  context '定量下限値が数字の場合' do
    let!(:test_item) { build(:test_item, detection_limit: Faker::Number.decimal(l_digits: 2)) }

    it '検査項目を保存できる' do
      expect(test_item).to be_valid
    end
  end

  context '定量下限値が空の場合' do
    let!(:test_item) { build(:test_item, detection_limit: nil) }

    it '検査項目を保存できる' do
      expect(test_item).to be_valid
    end
  end

  context '定量下限値が文字列の場合' do
    let!(:test_item) { build(:test_item, detection_limit: Faker::Lorem.characters(number: 21)) }

    before do
      test_item.save
    end
    it '検査項目を保存できない' do
      expect(test_item.errors.messages[:detection_limit][0]).to eq('は数値で入力してください')
    end
  end

  context '表示順が整数の場合' do
    let!(:test_item) { build(:test_item, sort_order: Faker::Number.number(digits: 10)) }

    it '検査項目を保存できる' do
      expect(test_item).to be_valid
    end
  end

  context '表示順が空の場合' do
    let!(:test_item) { build(:test_item, sort_order: nil) }

    it '検査項目を保存できる' do
      expect(test_item).to be_valid
    end
  end

  context '表示順が小数の場合' do
    let!(:test_item) { build(:test_item, sort_order: Faker::Number.decimal(l_digits: 2)) }

    before do
      test_item.save
    end
    it '検査項目を保存できない' do
      expect(test_item.errors.messages[:sort_order][0]).to eq('は整数で入力してください')
    end
  end
end
