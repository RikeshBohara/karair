class Job < ApplicationRecord
  belongs_to :user

  has_many :job_applications, dependent: :destroy
  enum :job_type, { "Full-time": 0, "Part-time": 1, "Contract": 2, "Internship": 3 }

  has_one_attached :image do |attachable|
    attachable.variant :card_image, resize_to_fill: [ 400, 300 ]
  end

  before_destroy :purge_image

  validates :title, presence: true
  validates :end_date, presence: true, inclusion: { in: (Date.today..), message: "must be in the future" }

  scope :active, -> { where("end_date >= ?", Date.today) }
  scope :expired, -> { where("end_date < ?", Date.today) }

  private

  def purge_image
    image.purge_later
  end
end
