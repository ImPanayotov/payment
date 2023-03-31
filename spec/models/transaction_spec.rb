require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'associations' do
    %i[customer merchant].each do |field|
      it { is_expected.to belong_to(field) }
    end

    it do
      is_expected.to have_many(:follow_transactions)
        .class_name('Transaction')
        .with_foreign_key('follow_transaction_id')
        .dependent(:restrict_with_error)
    end
  end

  describe 'enums' do
    let(:statuses) do
      { approved: 0,
        reversed: 1,
        refunded: 2,
        error: 3 }
    end

    it do
      is_expected.to define_enum_for(:status)
        .with_values(statuses)
        .with_suffix
    end
  end

  describe 'monetize' do
    it { is_expected.to monetize(:amount_cents).with_currency(:usd) }
  end

  describe 'columns' do
    it do
      is_expected.to have_db_column(:uuid)
        .of_type(:string)
        .with_options(null: false)
    end

    it do
      is_expected.to have_db_column(:status)
        .of_type(:integer)
        .with_options(null: false)
    end

    it do
      is_expected.to have_db_column(:type)
        .of_type(:string)
        .with_options(null: false, default: '')
    end

    it { is_expected.to have_db_column(:type).of_type(:string) }

    it do
      is_expected.to have_db_column(:amount_cents)
                       .of_type(:integer)
                       .with_options(null: false, default: 0)
    end

    it do
      is_expected.to have_db_column(:amount_currency)
                       .of_type(:string)
                       .with_options(null: false, default: 'USD')
    end

    %i[customer_id follow_transaction_id merchant_id].each do |index|
      it { is_expected.to have_db_index(index).unique(false) }
    end
  end
end
