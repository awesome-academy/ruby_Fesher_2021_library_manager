FactoryBot.define do
  factory :comment do
    content{Faker::Lorem.paragraph}
    rate_score{rand(0..5)}
  end
end
