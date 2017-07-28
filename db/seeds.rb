
Tag.destroy_all
Review.destroy_all
Product.destroy_all
Category.destroy_all
User.destroy_all
Like.destroy_all



tags = Tag.all
users = User.all

categories = ['Books', 'Techology', 'Computers', 'Movies', 'TV', 'Fashion', 'Music']

categories.each do |category|
 Category.create(name: category)
end


i ||= 0;
while i < 20 do
 u = User.create(
 first_name: Faker::Superhero.name,
 last_name: Faker::Superhero.name,
 email: "#{i}@email.com",
 password: "supersecret",
 )
 i = i + 1;
end

74.times do
  tag = Tag.create(name: Faker::Book.genre)
end


100.times do
 category = Category.all.sample

p = Product.create(
   title: Faker::Superhero.name,
   description: Faker::Hipster.sentence,
   price: Faker::Commerce.price,
   category_id: category.id,
   user_id: User.all.sample.id
 )
 p.tags = tags.shuffle.slice(0..rand(10))


 5.times do
   r = Review.create(
   product_id: p.id,
   body: Faker::Hipster.sentence,
   rating: rand(5),
   user_id: User.all.sample.id
   )
   rand(20).times do
     Like.create(
     user_id: User.all.sample.id,
     review_id: r.id
     )

  end
 end
end



puts "#{Product.count} products created!"
