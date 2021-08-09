class Step < ApplicationRecord
  belongs_to :milestone
  belongs_to :goal

  validates :title, presence: true
end
