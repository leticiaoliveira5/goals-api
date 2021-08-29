class Step < ApplicationRecord
  belongs_to :milestone

  validates :title, presence: true, length: { maximum: 50 }

  enum status: { inactive: 0, in_progress: 1, completed: 2 }

  def goal
    Goal.find(milestone.goal_id)
  end
end
