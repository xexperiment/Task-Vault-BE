class Task < ApplicationRecord
  belongs_to :user

  enum status: { pending: 0, in_progress: 1, completed: 2 }
  enum priority: { low: 0, medium: 1, high: 2 }

  validates :status, :priority, :deadline, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, presence: true
end
