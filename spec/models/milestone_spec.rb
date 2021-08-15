require 'rails_helper'

RSpec.describe Milestone, type: :model do
  context 'validation' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title) }
  end
end
