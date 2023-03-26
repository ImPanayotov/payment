require 'database_cleaner/active_record'

# Clean all database records
DatabaseCleaner.clean_with(:truncation)

10.times do
  FactoryBot.create(:merchant)
  FactoryBot.create(:customer)
end
