require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_length_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username) }
  end
end
