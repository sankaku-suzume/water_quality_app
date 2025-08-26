# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

plants = Plant.all

plants.each do |plant|
  3.times do |i|
    Sample.create!(
      plant: plant,
      sampling_date: Date.today - rand(1..30),   # 過去30日からランダム
      sampling_time: Time.now.change(hour: rand(8..15), min: [0, 15, 30, 45].sample),
      location: ["排水口A", "排水口B", "河川取水口"].sample,
      inspector: ["田中", "佐藤", "鈴木", "高橋"].sample,
      remarks: "サンプル#{i+1}（#{plant.name}）のテストデータです。"
    )
  end
end
