FactoryBot.define do
  factory :author do
    name{Faker::Name.name_with_middle}
    description{Faker::Lorem.paragraph}
  end
end
