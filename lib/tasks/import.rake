require 'csv'

namespace :import do
  desc 'Import merchants from CSV files'
  task merchants: :environment do
    merchants_file = 'lib/assets/csv_files/merchant_objects.csv'

    puts 'Importing merchants...'
    CSV.foreach(merchants_file, headers: true) do |row|
      # process the merchant data and create new merchant records
      Merchant.create!(
        email: row['email'],
        name: row['name'],
        description: row['description'],
        status: row['status'],
        password: row['password']
      )
    end

    puts 'Import completed successfully!'
  end

  desc 'Import admins from CSV file'
  task admins: :environment do
    admins_file = 'lib/assets/csv_files/admin_objects.csv'

    puts 'Importing admins...'
    CSV.foreach(admins_file, headers: true) do |row|
      # process the admin data and create new admin records
      Admin.create!(
        email: row['email'],
        first_name: row['first_name'],
        last_name: row['last_name'],
        role: row['role'],
        status: row['status'],
        password: row['password']
      )
    end

    puts 'Import completed successfully!'
  end
end
