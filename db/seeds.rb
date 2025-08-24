# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


Plant.destroy_all

plants = [
  {
    name: "札幌第一水処理センター",
    location: "北海道札幌市中央区○○1-2-3",
    remarks: "札幌市内の主要な処理場。冬季は水温が低い傾向あり。"
  },
  {
    name: "東京湾臨海工場",
    location: "東京都江東区△△4-5-6",
    remarks: "海水の影響を受けやすく、塩分やpHの変動に注意。"
  },
  {
    name: "大阪工業団地排水処理場",
    location: "大阪府堺市××7-8-9",
    remarks: "工場排水が混ざるためBOD・SSが高くなりやすい。"
  },
  {
    name: "名古屋食品加工団地排水処理場",
    location: "愛知県名古屋市○○10-11-12",
    remarks: "食品系工場排水の影響で有機物負荷が高い。"
  },
  {
    name: "福岡化学工場専用処理場",
    location: "福岡県北九州市△△13-14-15",
    remarks: "化学工場専用の処理場。特殊検査項目が追加されることもある。"
  }
]

plants.each do |plant_data|
  Plant.create!(plant_data)
end

puts "🌱 Plant seeds created! (#{Plant.count}件)"