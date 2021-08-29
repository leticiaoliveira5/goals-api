require 'rails_helper'

RSpec.describe Step, type: :model do
  context 'validation' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title) }
  end

  context '#goal' do
    it 'returns goal' do
      goal = create(:goal)
      milestone = create(:milestone, goal: goal)
      step = create(:step, milestone: milestone)

      expect(step.goal).to eq goal
    end
  end
end
