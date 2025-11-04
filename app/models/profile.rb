class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :photo
  has_one_attached :resume

  validates :first_name, :last_name, presence: true, if: -> { user&.applicant? }
  validates :company_name, presence: true, if: -> { user&.recruiter? }
  validates :contact, format: {
    with: /\A\+?[0-9\s\-]{7,15}\z/,
    message: "must be a valid phone number"
  }, allow_blank: true

  validates :location, presence: true

  validate :resume_format, if: -> { user&.applicant? }
  validate :photo_size_within_limit
  validate :resume_size_within_limit, if: -> { user&.applicant? }

  after_save :update_profile_completed

  def completed?
    if user.applicant?
      first_name.present? &&
      last_name.present? &&
      contact.present? &&
      location.present? &&
      resume.attached? &&
      photo.attached?
    elsif user.recruiter?
      company_name.present? &&
      photo.attached? &&
      contact.present? &&
      location.present?
    else
      false
    end
  end

  private

  def update_profile_completed
    if user.profile_completed != completed?
      user.update_column(:profile_completed, completed?)
    end
  end

  def resume_format
    return unless resume.attached?
    unless resume.content_type=="application/pdf"
      errors.add(:resume, "must be a PDF file")
    end
  end

  # Enforce maximum attachment sizes
  def photo_size_within_limit
    return unless photo.attached?
    max_bytes = 2.megabytes
    if photo.blob.byte_size > max_bytes
      errors.add(:photo, "is too large (max 2 MB)")
    end
  end

  def resume_size_within_limit
    return unless resume.attached?
    max_bytes = 5.megabytes
    if resume.blob.byte_size > max_bytes
      errors.add(:resume, "is too large (max 5 MB)")
    end
  end

  public

  # Returns an Active Storage variant for the photo sized to a square avatar.
  def avatar_variant(size_px = 80)
    return unless photo.attached?
    photo.variant(resize_to_fill: [ size_px, size_px ]).processed
  end
end
