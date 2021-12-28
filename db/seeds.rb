User.create!(name: "Lê Phương Tây",
  email: "tay@gmail.com",
  password: "lephuongtay",
  password_confirmation: "lephuongtay",
  is_admin: true,
  is_permited: true,
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
      is_permited: true,
      address: address,
      phone: phone)
  end
  50.times do |n|
    name = Faker::Name.name
    descripton = Faker::Lorem.paragraph
    Author.create!(name: name,
      description: descripton)
  end
