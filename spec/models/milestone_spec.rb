require 'rails_helper'

RSpec.describe Milestone, type: :model do
  context 'validation' do
    it { should validate_presence_of(:title) }
  end
end
