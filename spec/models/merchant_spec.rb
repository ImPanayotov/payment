require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:transactions).dependent(:restrict_with_exception) }
    it { is_expected.to have_many(:follow_transactions).through(:transactions) }
  end

  describe 'validations' do
    %i[name email].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    it { is_expected.to validate_length_of(:name).is_at_most(255) }

    it { is_expected.to allow_value('merchant@email.com').for(:email) }
  end

  describe 'enums' do
    it do
      is_expected.to define_enum_for(:status)
        .with_values({ active: 0, inactive: 1 })
    end
  end

  describe 'monetize' do
    it { is_expected.to monetize(:total_transaction_sum_cents).with_currency(:usd) }
  end

  describe 'columns' do
    it do
      is_expected.to have_db_column(:name)
        .of_type(:string)
        .with_options(null: false, limit: 255, default: '')
    end

    it do
      is_expected.to have_db_column(:description)
        .of_type(:text)
    end

    it do
      is_expected.to have_db_column(:jti)
        .of_type(:string)
    end

    it do
      is_expected.to have_db_column(:email)
        .of_type(:string)
        .with_options(null: false, default: '')
    end

    it do
      is_expected.to have_db_column(:total_transaction_sum_cents)
        .of_type(:integer)
        .with_options(null: false, default: 0)
    end

    it do
      is_expected.to have_db_column(:total_transaction_sum_currency)
        .of_type(:string)
        .with_options(null: false, default: 'USD')
    end

    %i[email reset_password_token].each do |index|
      it { is_expected.to have_db_index(index).unique }
    end

    it { is_expected.to have_db_index(:jti).unique(false) }
  end
end
