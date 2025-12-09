class JobApplication < ApplicationRecord
  belongs_to :user
  belongs_to :job


  validates :cover_letter, presence: true
  validates :user_id, uniqueness: { scope: :job_id, message: "You have already applied for this job" }
end
