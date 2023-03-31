FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { "#{first_name.chr}.#{last_name}@#{Faker::Internet.domain_name}" }
    phone { Faker::PhoneNumber.cell_phone }
    password { 'Password123!' }
    amount_cents { 1_000_000 }
  end
end
