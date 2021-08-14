class Step < ApplicationRecord
  belongs_to :milestone
  belongs_to :goal

  validates :title, presence: true

  enum status: { inactive: 0, in_progress: 1, completed: 2 }
end
