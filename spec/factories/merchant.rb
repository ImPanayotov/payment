FactoryBot.define do
  factory :merchant do
    email { Faker::Internet.email }
    password { 'Password123!' }
    name { email.split(/@/)[1].split(/[-_.]/).reverse.drop(1).join(' ').titleize.concat(" #{Faker::Company.suffix}") }
    description { Faker::Company.catch_phrase }
    status { 'active' }
    total_transaction_sum_cents { 0 }
  end
end
