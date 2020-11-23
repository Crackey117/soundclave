# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  user1 = User.create(
    email: "blah@gmail.com", 
    first_name: "blah",
    last_name: "blah",
    password: "blahblah",
    username: "BlahBlahWhat",
    role: "Fan"
  )
  user2 = User.create(
    email: "example@example.com", 
    first_name: "example",
    last_name: "example",
    password: "hithere",
    username: "ThatGuy",
    role: "Fan"
  )

post1 = Post.create(body: "I cant wait for live music to start up again, the winter is gonna be sloowwwwwww", user_id: user2.id)
post2 = Post.create(body: "Apparently there are still shows in Florida", user_id: user1.id)
post3 = Post.create(body: "Ill put on a coat and mittens, just give me outdoor shows!", user_id: user2.id)