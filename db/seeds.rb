# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

require 'csv'
province_data = File.read("#{Rails.root}/public/canadian-provinces.json")
records = JSON.parse(province_data)
records.each do |_short, full|
  Province.create!(name: full)
end
puts "#{Province.count} are seeded"

cgrs = Category.create(
  name: 'Pcs-Laptop',
  description: 'High end pc-laptop'
)

laptop_data = File.read("#{Rails.root}/public/data_laptop.csv")

laptops = CSV.parse(laptop_data, headers: true)

laptops.each do |row|
  prod = cgrs.products.create(name: row[0], price: row['Price'], description: row[0])
  downloaded_image = open(URI.escape(row['Thumbnail']))
  prod.product_image.attach(io: downloaded_image, filename: "image-#{row[0]}.jpg")
end
