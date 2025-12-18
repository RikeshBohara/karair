class JobApplication < ApplicationRecord
  belongs_to :user
  belongs_to :job

  enum :status, { pending: 0, emailed: 1, rejected: 2 }

  validates :cover_letter, presence: true
  validates :user_id, uniqueness: { scope: :job_id, message: "You have already applied for this job" }
end
