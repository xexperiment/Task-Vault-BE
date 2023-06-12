require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:status).with_values(pending: 0, in_progress: 1, completed: 2) }
    it { is_expected.to define_enum_for(:priority).with_values(low: 0, medium: 1, high: 2) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:priority) }
    it { is_expected.to validate_presence_of(:deadline) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(30) }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe 'db columns' do
    it { is_expected.to have_db_column(:title).of_type(:string).with_options(null: false, limit: 25) }
    it { is_expected.to have_db_column(:description).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:status).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:priority).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:deadline).of_type(:datetime).with_options(null: false) }
  end
end
