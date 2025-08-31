# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

test_items = [
  {
    name: "水温",
    unit: "℃",
    detection_limit: 0.1,
    standard_min: nil,
    standard_max: nil
  },
  {
    name: "pH",
    unit: "-",
    detection_limit: 0.1,
    standard_min: 5.8,
    standard_max: 8.6
  },
  {
    name: "BOD",
    unit: "mg/L",
    detection_limit: 0.5,
    standard_min: nil,
    standard_max: 20.0
  },
  {
    name: "SS",
    unit: "mg/L",
    detection_limit: 1.0,
    standard_min: nil,
    standard_max: 30.0
  },
  {
    name: "大腸菌数",
    unit: "CFU/100mL",
    detection_limit: 1.0,
    standard_min: nil,
    standard_max: 1000.0
  }
]

test_items.each do |item|
  TestItem.find_or_create_by!(name: item[:name]) do |t|
    t.unit = item[:unit]
    t.detection_limit = item[:detection_limit]
    t.standard_min = item[:standard_min]
    t.standard_max = item[:standard_max]
  end
end
