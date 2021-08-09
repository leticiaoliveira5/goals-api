class Milestone < ApplicationRecord
  belongs_to :goal
  has_many :steps, dependent: :destroy

  validates :title, presence: true
end
