require 'rails_helper'

RSpec.describe Goal, type: :model do
  context 'validation' do
    new_goal = Goal.new(title: '', deadline: 2.days.ago)

    it 'must have title' do
      expect(new_goal).not_to be_valid
      expect(new_goal.errors.messages[:title]).to be_present
    end
    it 'deadline must be in the future' do
      expect(new_goal.errors.messages[:deadline]).to be_present
    end
  end
end
