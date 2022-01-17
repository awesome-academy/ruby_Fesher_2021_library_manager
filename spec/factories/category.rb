FactoryBot.define do
  factory :category do
    name{Faker::Name.name_with_middle}
  end
end
