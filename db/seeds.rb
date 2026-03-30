# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

require 'faker'

Faker::Config.locale = :ja

# リセット
Approval.destroy_all
Result.destroy_all
Sample.destroy_all
Plant.destroy_all
TestItem.destroy_all

puts "seed start"

# 検査項目マスタ
test_items = [
  { name: "水温", unit: "℃" },
  { name: "pH", unit: nil },
  { name: "SS", unit: "mg/L" },
  { name: "BOD", unit: "mg/L" },
  { name: "大腸菌数", unit: "CFU/100mL" }
]

test_items.each_with_index do |item, i|
  TestItem.create!(
    name: item[:name],
    unit: item[:unit],
    sort_order: i + 1
  )
end

test_items = TestItem.all

# 日本語っぽい採水場所
locations = ["排水口A", "排水口B", "排水口C", "放流口", "沈殿槽出口"]

# 事業場30件
30.times do
  plant = Plant.create!(
    name: Faker::Company.name,
    location: Faker::Address.full_address,
    remarks: Faker::Lorem.sentence
  )

  # 各事業場に3検体
  3.times do
    sample = plant.samples.create!(
      sampling_date: Faker::Date.backward(days: 10),
      sampling_time: Time.zone.parse("#{rand(0..23)}:#{[0,15,30,45].sample}"),
      location: locations.sample,
      inspector: Faker::Name.name,
      remarks: Faker::Lorem.sentence
    )

    # 各検体に検査結果
    test_items.each do |item|
      value =
        case item.name
        when "水温"
          rand(10.0..30.0).round(1)
        when "pH"
          rand(5.5..8.5).round(1)
        when "SS"
          rand(1..50)
        when "BOD"
          rand(1..20)
        when "大腸菌数"
          rand(0..1000)
        end

      result = sample.results.create!(
        test_item: item,
        value: value.to_s
      )
      
      # 承認履歴（時系列を保証）
      base_time = Faker::Time.backward(days: 3)

      # ① 承認依頼
      result.approvals.create!(
        action: :requested,
        user_name: Faker::Name.name,
        comment: "確認お願いします",
        created_at: base_time
      )

      current_time = base_time

      # ② 差戻し（20%）
      if rand < 0.2
        current_time += rand(1..3).hours

        result.approvals.create!(
          action: :rejected,
          user_name: Faker::Name.name,
          comment: "値を再確認してください",
          created_at: current_time
        )

        # ③ 再依頼
        current_time += rand(1..3).hours

        result.approvals.create!(
          action: :requested,
          user_name: Faker::Name.name,
          comment: "修正しました",
          created_at: current_time
        )
      end

      # ④ 承認
      current_time += rand(1..3).hours

      result.approvals.create!(
        action: :approved,
        user_name: Faker::Name.name,
        comment: "承認しました",
        created_at: current_time
      )
    end
  end
end

puts "seed complete"
