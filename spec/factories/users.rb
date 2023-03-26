FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { "#{first_name.chr}.#{last_name}@#{Faker::Internet.domain_name}" }
    password { 'Password123!' }

    trait :admin do
      role { 'admin' }
    end
  end
end
