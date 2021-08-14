require 'rails_helper'

RSpec.describe Step, type: :model do
  context 'validation' do
    new_step = Step.new(title: '')

    it 'must have title' do
      expect(new_step).not_to be_valid
      expect(new_step.errors.messages[:title]).to be_present
    end
  end
end
