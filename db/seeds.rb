User.create!(name: "Lê Phương Tây",
  email: "tay@gmail.com",
  password: "lephuongtay",
  password_confirmation: "lephuongtay",
  is_admin: true,
  confirmed_at: Time.now,
  address: "649/27/1 Điện Biên Phủ",
  phone: "0393203261")
  50.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    address = "#{n+1} điện biên phủ, phường #{n%10}"
    phone = "0393203261"
    password = "password"
    User.create!(name: name,
      email: email,
      password: password,
      password_confirmation: password,
      is_admin: false,
      confirmed_at: Time.now,
      address: address,
      phone: phone)
  end
  50.times do |n|
    name = Faker::Name.name
    descripton = Faker::Lorem.paragraph
    Author.create!(name: name,
      description: descripton)
  end
  50.times do |n|
    name = "Nxb "<< Faker::Name.name
    descripton = Faker::Lorem.paragraph
    Publisher.create!(name: name,
      description: descripton)
  end
  10.times do |n|
    name = "Mục "<< Faker::Name.name
    Category.create!(name: name)
  end
  50.times do |n|
    name = "Sách "<< Faker::Name.name
    price = rand(2..100)*10000
    description = Faker::Lorem.paragraph
    number_of_page = rand(100..500)
    quantity = rand(1..20)
    author_id = rand(1..10)
    publisher_id = rand(1..10)
    category_id = rand(1..10)
    rate_score = rand(0..5)
    Book.create!(name: name,
                 price: price,
                 description: description,
                 number_of_page: number_of_page,
                 quantity: quantity,
                 author_id: author_id,
                 publisher_id: publisher_id,
                 category_id: category_id,
                 rate_score: rate_score
                )
  end
