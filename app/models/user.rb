class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :role, presence: true

  enum :role, { recruiter: 0, applicant: 1 }

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  after_create :build_default_profile

  def build_default_profile
    build_profile.save(validate: false)
  end
end
