require 'database_cleaner/active_record'

# Clean all database records
DatabaseCleaner.clean_with(:truncation)

10.times do
  email = Faker::Internet.email

  Merchant.create!(
    email:,
    password: 'Password123!',
    name: email.split(/@/)[1].split(/[-_.]/).reverse.drop(1).join(' ').titleize.concat(" #{Faker::Company.suffix}"),
    description: Faker::Company.catch_phrase,
    status: 'active',
    total_transaction_sum_cents: 100_00
  )
end

10.times do
  FactoryBot.create(:customer)
end
