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

puts "🌱 Seeding started..."

# --- Users ---
puts "👤 Creating users..."
User.destroy_all
admin = User.create!(
  name: "管理者ユーザー",
  email: "admin@example.com",
  password: "password",
  admin: true
)
user  = User.create!(
  name: "一般ユーザー",
  email: "user@example.com",
  password: "password",
  admin: false
)
puts "✅ Users created: #{User.count}"

# --- Plants ---
puts "🏭 Creating plants..."
Plant.destroy_all
plants = Plant.create!([
  { name: "札幌第一事業場", location: "北海道札幌市中央区南1条西1丁目", remarks: "地下水利用施設あり" },
  { name: "函館工場", location: "北海道函館市港町", remarks: "海水近接" },
  { name: "旭川事業場", location: "北海道旭川市神楽岡", remarks: "" }
])
puts "✅ Plants created: #{Plant.count}"

# --- Samples ---
puts "💧 Creating samples..."
Sample.destroy_all
samples = []
plants.each do |plant|
  3.times do |i|
    samples << Sample.create!(
      plant: plant,
      sampling_date: Date.today - i.days,
      sampling_time: Time.zone.parse("10:00"),
      location: "排水口A",
      inspector: "田中太郎",
      remarks: "定期採水"
    )
  end
end
puts "✅ Samples created: #{Sample.count}"

# --- Test Items ---
puts "🧪 Creating test items..."
TestItem.destroy_all
test_items = TestItem.create!([
  { name: "水温", unit: "℃", detection_limit: 0.1, standard_min: nil, standard_max: nil },
  { name: "pH", unit: "-", detection_limit: 0.01, standard_min: 5.8, standard_max: 8.6 },
  { name: "BOD", unit: "mg/L", detection_limit: 0.5, standard_min: nil, standard_max: 20.0 },
  { name: "SS", unit: "mg/L", detection_limit: 1.0, standard_min: nil, standard_max: 30.0 },
  { name: "大腸菌数", unit: "CFU/100mL", detection_limit: 1.0, standard_min: nil, standard_max: 1000.0 }
])
puts "✅ Test items created: #{TestItem.count}"

# --- Results ---
puts "📊 Creating results..."
Result.destroy_all
samples.each do |sample|
  test_items.each do |item|
    value = case item.name
    when "水温" then rand(10.0..25.0).round(1)
    when "pH" then rand(6.0..8.0).round(2)
    when "BOD" then rand(1.0..15.0).round(1)
    when "SS" then rand(1.0..20.0).round(1)
    when "大腸菌数" then rand(0..800)
    else rand(1.0..10.0)
    end
    Result.create!(sample: sample, test_item: item, value: value)
  end
end
puts "✅ Results created: #{Result.count}"

puts "🎉 All done!"
