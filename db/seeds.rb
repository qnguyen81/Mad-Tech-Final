# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# if Rails.env.development?
#   AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
# end

# province_data = File.read("#{Rails.root}/public/canadian-provinces.json")
# records = JSON.parse(province_data)
# records.each do |_short, full|
#   Province.create!(name: full)
# end
# puts "#{Province.count} are seeded"
cgrs = Category.where('name == "Laptop"')

laptop_data = File.read("#{Rails.root}/public/laptops.csv")
laptops = CSV.parse(laptop_data, headers: true)

laptops.each do |row|
  # category.products.create(name: full.Product, price: full.Price_euros, description: full.Inches + full.TypeName + )
  puts row['TypeName'] + ' ' + row['Inches'] + ' ' + row['ScreenResolution'] + ' ' + row['Cpu'] + ' ' + row['Ram'] + ' ' + row['Memory'] + ' ' + row['Gpu'] + ' ' + row['OpSys']
end
