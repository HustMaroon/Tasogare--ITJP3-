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
NUMBER_OF_USERS = 10
NUMBER_OF_USERS.times do |i|
  user = User.create!(email: "user#{i}@tasogare.com", password: "123456", password_confirmation: "123456")
  puts "Created an ordinary user with email #{user.email}"
end

MAX_NUMBER_OF_ITEMS_FOF_EACH_USER = 10
# Add some items for each user
User.general_users.each do |user|
  number_of_items = rand(MAX_NUMBER_OF_ITEMS_FOF_EACH_USER + 1)
  number_of_items.times do |j|
    item = Item.create!(user: user, name:"computer#{j}")
  end
  puts "Created #{number_of_items} items for user #{user.email}"
end

user_id = User.second.id
item1 = Item.create(name: "MacBook Pro 2016",
            detail_review: "To say the new MacBook Pro is a massive improvement over the previous 
                            model would be an understatement. It's more portable and more powerful,
                            not to mention more enjoyable to use. But it's tough to justify the
                             premium for that Touch Bar, no matter how cool it is.", approved: true,
                            user_id: user_id, rate: 5)
File.open("app/assets/images/MAC-2016.jpg") do |f|
  item1.image = f
  item1.save
end

item2 = Item.create(name: "Asus ROG G752VS OC Edition",
            detail_review: "George R.R. Martin's best-selling book series \"A Song of Ice and Fire\"
                           is brought to the screen as HBO sinks its considerable storytelling teeth
                          into the medieval fantasy epic. It's the depiction of two powerful families
                           -- kings and queens, knights and renegades, liars and honest men -- ", 
                           approved: true, user_id: user_id, rate: 5)
File.open("app/assets/images/asus-g752v-nw-g01.jpg") do |f|
  item2.image = f
  item2.save
end

item3 = Item.create(name: "Dell Inspiron 11 3000",
            detail_review: "The Dell Inspiron 11 3000 offers long battery life in a stylish and compact 
                            design, but the display and keyboard could be better.", 
                           approved: true, user_id: user_id, rate: 4)
File.open("app/assets/images/dell-inspiron-11-3000-2016-nw-g01.jpg") do |f|
  item3.image = f
  item3.save
end

item4 = Item.create(name: "HP Elitebook 8560p",
            detail_review: "This HP business notebook, the Elitebook 8560p LQ589AW, has a new and professional-looking design. Instead of using the usual black plastic or aluminium for this series, 
                            HP has opted for a compact case which is made of aluminium but looks like platinum", 
                           approved: true, user_id: user_id, rate: 5)
File.open("app/assets/images/hp_elite_book.jpg") do |f|
  item4.image = f
  item4.save
end

item5 = Item.create(name: "Apple MacBook Pro 15 (Late 2016, 2.6 GHz i7)",
            detail_review: "Apple slims down the MacBook Pro 15 quite radically and reduces the weight to around 
                            1.8 kg with a thickness of just 16 millimeters. The professional notebook, which even 
                            gained customers from the 17-inch Pro in the past, is now even a real alternative for users of the previous MBP 13.", 
                           approved: true, user_id: user_id, rate: 4.5)
File.open("app/assets/images/mac.jpg") do |f|
  item5.image = f
  item5.save
end

item6 = Item.create(name: "Aorus X7 DT v6 Notebook",
            detail_review: "Boundless performance. Gigabyte has taken the design of their AORUS gaming notebook to
                           the next level with the advent of the X7 DT v6. With class-leading GPU and CPU performance,
                            speedy solid-state storage, and powerful networking and display options, can anything slow it down?", 
                           approved: true, user_id: user_id, rate: 4.5)
File.open("app/assets/images/aroux.jpg") do |f|
  item6.image = f
  item6.save
end

item7 = Item.create(name: "EVGA SC17 GTX 1070 Notebook",
            detail_review: "More power, same features. The impressive overclock-ready SC17 is now officially on the 
                            Pascal train, but its continuing lack of features puts the notebook at a disadvantage in the 17-inch gaming category.", 
                           approved: true, user_id: user_id, rate: 4.5)
File.open("app/assets/images/evga.jpg") do |f|
  item7.image = f
  item7.save
end
