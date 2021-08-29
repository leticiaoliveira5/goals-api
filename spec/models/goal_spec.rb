require 'rails_helper'

RSpec.describe Goal, type: :model do
  context 'validation' do
    it { should validate_presence_of(:title) }
    it { should_not allow_value(1.day.ago).for(:deadline) }
    it { should validate_length_of(:title) }
  end
end
