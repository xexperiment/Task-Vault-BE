require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:tasks).dependent(:destroy) }
  end

  describe 'db columns' do
    it { is_expected.to have_db_column(:first_name).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:last_name).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:email).of_type(:string).with_options(null: false) }
  end
end
