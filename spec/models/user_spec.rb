require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    %i[first_name
       last_name
       email
       role
       status].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    %i[first_name last_name].each do |field|
      it { is_expected.to validate_length_of(field).is_at_most(255) }
    end

    it do
      expect(subject).to validate_inclusion_of(:role).in_array(described_class::ROLES)
    end

    it { is_expected.to allow_value('admin_user@email.com').for(:email) }
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
      expect(subject).to have_db_column(:email)
        .of_type(:string)
        .with_options(null: false, default: '')
    end

    it do
      expect(subject).to have_db_column(:status)
        .of_type(:integer)
        .with_options(null: false, default: 'active')
    end

    it do
      expect(subject).to have_db_column(:role)
        .of_type(:string)
        .with_options(null: false, default: 'user')
    end

    %i[email reset_password_token].each do |index|
      it { is_expected.to have_db_index(index).unique }
    end
  end

  describe 'scopes' do
    let(:user) do
      create(:user)
    end

    let(:admin) do
      create(:user, :admin)
    end

    before do
      user
      admin
    end

    describe '.admins' do
      context "returns users with 'admin' role" do
        let(:result) do
          described_class.admins
        end

        let(:same_roles?) do
          # It's checking whether all records from the result are with the current role
          result.all?(&:admin_role?)
        end

        it "returns users with 'admin' role" do
          expect(same_roles?).to be_truthy
        end
      end
    end

    describe '.users' do
      context "returns users with 'user' role" do
        let(:result) do
          described_class.users
        end

        let(:same_roles?) do
          # check whether all records from the result are with the current role
          result.all?(&:user_role?)
        end

        it "returns users with 'user' role" do
          expect(same_roles?).to be_truthy
        end
      end
    end

    described_class::ROLES.each do |role|
      describe ".with_role(#{role})" do
        let(:result) do
          described_class.with_role(role)
        end

        let(:same_roles?) do
          # check whether all records from the result are with the current role
          result.all? do |rec|
            rec.public_send("#{role}_role?")
          end
        end

        it "includes #{role}" do
          expect(same_roles?).to be_truthy
        end
      end
    end
  end
end
