FactoryBot.define do
  factory :publisher do
    name{Faker::Name.name_with_middle}
    description{Faker::Lorem.paragraph}
  end
end
