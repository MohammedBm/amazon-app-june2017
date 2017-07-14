# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# 1000.times do
#   p = Product.create(
#     title:Faker::Superhero.name,
#     description:Faker::Hipster.sentence,
#     price:Faker::Commerce.price
#   )
#
#
#   puts " Products #{p.title} Created"
# categories = ['Books', 'Technology', 'Computer', 'Movies', 'TV', 'Fashion', 'Music']
# categories.each do |category|
#   Category.create(name: category)
# end
#
#
#
#
# 1000.times do
#   c = Category.all.sample
#   p = User.create(
#   first:Faker::Name.first_name,
#   last:Faker::Name.last_name,
#   email:Faker::Internet.email
#   )
#
#
# PASSWORD = '1q2w'
# Product.destroy_all
# Category.destroy_all
# User.destroy_all
#
# categories = ['Books', 'Technology', 'Computer', 'Movies', 'TV', 'Fashion', 'Music']
#
# categories.each do |category|
#   Category.create(name: category)
# end
#
# 20.times do
#   user = Faker::StarWars.character
#   email = user.delete(' ').downcase
#   names = user.split(' ')
#
#   User.create(
#   email: "#{email}@w.cn",
#   first_name:names.first,
#   last_name:names.last,
#   password:PASSWORD,
#   password_confirmation:PASSWORD
#   )
# end
#
#
# 1000.times do
#   c = Category.all.sample
#   user = User.all.sample
#   Product.create(
#   title: Faker::Superhero.name,
#   description: Faker::Hipster.sentence,
#   price: Faker::Commerce.price,
#   category_id: c.id,
#   user_id: user.id
#   )
# end
#
# puts "#{Product.count} products created"
Review.destroy_all
Product.destroy_all
Category.destroy_all
User.destroy_all

categories = ['Books', 'Techology', 'Computers', 'Movies', 'TV', 'Fashion', 'Music']

categories.each do |category|
  Category.create(name: category)
end

150.times do
  user = Faker::Name.name
  email = user.delete(' ').downcase
  names = user.split(' ')

  User.create(
    email: "#{email}@cohort19.com",
    first_name: names.first,
    last_name: names.last,
    password: '1q',
    password_confirmation: '1q'
  )
end

1000.times do
  category = Category.all.sample
  user = User.all.sample

  p = Product.create(
    title: Faker::Superhero.name,
    description: Faker::Hipster.sentence,
    price: Faker::Commerce.price,
    category_id: category.id,
    user_id: user.id
  )

  if p.persisted?
    5.times do
      reviewer = User.all.sample
      rating = [1, 2, 3, 4, 5].sample

      p.reviews.create(
        body:       Faker::Hipster.paragraph(5),
        rating:     rating,
        user_id:    reviewer.id
      )
    end
  end
end

puts "#{Product.count} products created!"
