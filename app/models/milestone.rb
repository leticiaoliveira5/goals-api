class Milestone < ApplicationRecord
  belongs_to :goal
  has_many :steps, dependent: :destroy

  validates :title, presence: true

  enum status: { inactive: 0, in_progress: 1, completed: 2 }
end
