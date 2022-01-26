FactoryBot.define do
  factory :book do
    name{Faker::Name.name_with_middle}
    price{Faker::Number.between(from: 20000, to: 500000)}
    description{Faker::Lorem.paragraph}
    number_of_page{rand(100..500)}
    quantity{rand(1..20)}
  end
end
