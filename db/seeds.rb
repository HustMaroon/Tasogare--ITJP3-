# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

master_klass = [User, Item, Rating]

master_klass.each do |klass|
  klass.destroy_all
  puts "Deleted all #{klass} data"
end

# Add super admin
admin = User.create!(admin:true, email: "admin@tasogare.com", password: "123456", password_confirmation: "123456")
puts "Created a admin with email #{admin.email}"


# Add some ordinary users
NUMBER_OF_USERS = 50
NUMBER_OF_USERS.times do |i|
  user = User.create!(email: "user#{i}@tasogare.com", password: "123456", password_confirmation: "123456")
  puts "Created an ordinary user with email #{user.email}"
end

MAX_NUMBER_OF_ITEMS_FOF_EACH_USER = 20
# Add some items for each user
User.general_users.each do |user|
  number_of_items = rand(MAX_NUMBER_OF_ITEMS_FOF_EACH_USER + 1)
  number_of_items.times do |j|
    item = Item.create!(user: user, name:"computer#{j}")
  end
  puts "Created #{number_of_items} items for user #{user.email}"
end

MAX_NUMBER_OF_RATINGS_EACH_ITEM = 30
Item.all.each do |item|
	number_of_ratings = rand(MAX_NUMBER_OF_RATINGS_EACH_ITEM + 1)
	user = User.all[rand(50)]
	rate = 0.5*rand(10)
	item.ratings.create!(user: user, rate: rate )
	puts "created a random rate #{rate} for item with id #{item.id} and user #{user.id}" 
end


