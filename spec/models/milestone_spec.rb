require 'rails_helper'

RSpec.describe Milestone, type: :model do
  context 'validation' do
    new_milestone = Milestone.new(title: '')

    it 'must have title' do
      expect(new_milestone).not_to be_valid
      expect(new_milestone.errors.messages[:title]).to be_present
    end
  end
end
