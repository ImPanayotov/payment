require 'rails_helper'

RSpec.describe Customer do
  describe 'associations' do
    it { is_expected.to have_many(:transactions).dependent(:restrict_with_error) }
    it { is_expected.to have_many(:follow_transactions).through(:transactions) }
  end

  describe 'validations' do
    %i[first_name
       last_name
       email
       phone].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    %i[first_name last_name].each do |field|
      it { is_expected.to validate_length_of(field).is_at_most(255) }
    end

    it { is_expected.to validate_length_of(:phone).is_at_most(15) }

    it { is_expected.to allow_value('customer@email.com').for(:email) }
  end

  describe 'monetize' do
    it { is_expected.to monetize(:amount_cents).with_currency(:usd) }
  end

  describe 'columns' do
    %i[first_name last_name].each do |column|
      it do
        expect(subject).to have_db_column(column)
          .of_type(:string)
          .with_options(null: false, limit: 255, default: '')
      end
    end

    it do
      expect(subject).to have_db_column(:phone)
        .of_type(:string)
        .with_options(null: false, limit: 15, default: '')
    end

    it do
      expect(subject).to have_db_column(:email)
        .of_type(:string)
        .with_options(null: false, default: '')
    end

    it do
      expect(subject).to have_db_column(:amount_cents)
        .of_type(:integer)
        .with_options(null: false, default: 0)
    end

    it do
      expect(subject).to have_db_column(:amount_currency)
        .of_type(:string)
        .with_options(null: false, default: 'USD')
    end

    %i[email reset_password_token].each do |index|
      it { is_expected.to have_db_index(index).unique }
    end
  end
end
