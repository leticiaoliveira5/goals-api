class Goal < ApplicationRecord
  # belongs_to :user
  has_many :milestones, dependent: :destroy
  has_many :steps, through: :milestones

  validates :title, presence: true
  validate :deadline_validation

  enum status: { on_hold: 0, in_progress: 1, completed: 2 }

  def deadline_validation
    errors.add(:deadline, 'Deadline has to be in the future') if deadline.present? && deadline < DateTime.now
  end
end
