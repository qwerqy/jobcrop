class User < ApplicationRecord
  include Clearance::User
  mount_uploader :image, AvatarUploader

	has_many :jobs
	has_many :bookings

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, if: :email
  validates :password, presence: true, if: :password

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def own_profile?(user)
    self.id == user.id
  end
end
