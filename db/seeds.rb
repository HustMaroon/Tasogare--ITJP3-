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

user_id = User.second.id
item1 = Item.create(name: "MacBook Pro 2016",
            detail_review: "To say the new MacBook Pro is a massive improvement over the previous 
                            model would be an understatement. It's more portable and more powerful,
                            not to mention more enjoyable to use. But it's tough to justify the
                             premium for that Touch Bar, no matter how cool it is.", approved: true,
                            user_id: user_id)
File.open("app/assets/images/MAC-2016.jpg") do |f|
  item1.image = f
  item1.save
end

item2 = Item.create(name: "Asus ROG G752VS OC Edition",
            detail_review: "George R.R. Martin's best-selling book series \"A Song of Ice and Fire\"
                           is brought to the screen as HBO sinks its considerable storytelling teeth
                          into the medieval fantasy epic. It's the depiction of two powerful families
                           -- kings and queens, knights and renegades, liars and honest men -- ", 
                           approved: true, user_id: user_id)
File.open("app/assets/images/asus-g752v-nw-g01.jpg") do |f|
  item2.image = f
  item2.save
end

item3 = Item.create(name: "Dell Inspiron 11 3000", image: "http://www.laptopmag.com/images/uploads/4217/g/dell-inspiron-11-3000-2016-nw-g01.jpg",
            detail_review: "The Dell Inspiron 11 3000 offers long battery life in a stylish and compact 
                            design, but the display and keyboard could be better.", 
                           approved: true, user_id: user_id)
File.open("dell-inspiron-11-3000-2016-nw-g01.jpg") do |f|
  item3.image = f
  item3.save
end
