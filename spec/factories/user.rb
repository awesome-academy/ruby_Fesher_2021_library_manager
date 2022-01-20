FactoryBot.define do
  factory :user do
    name{Faker::Name.name_with_middle}
    email{Faker::Internet.email.downcase}
    phone{"0393203261"}
    confirmed_at{Time.zone.now}
    address{Faker::Address.street_address}
    password{"password!@#"}
    password_confirmation{"password!@#"}
  end
end
