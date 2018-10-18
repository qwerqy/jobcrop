class User < ApplicationRecord
  include Clearance::User
  mount_uploader :avatar, AvatarUploader
  acts_as_taggable_on :skills

	has_many :languages, dependent: :destroy
	has_many :experiences, dependent: :destroy
	has_many :educations, dependent: :destroy
	has_many :skills, dependent: :destroy
	has_many :projects, dependent: :destroy

  has_one :employer, dependent: :destroy
  has_one :jobhunter, dependent: :destroy

  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id'
  has_many :personal_messages, dependent: :destroy

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

  def registered?
    self.employer.present?
  end

  def location
    	"#{self.address} #{self.state} #{self.country} #{self.zipcode}"
 	end

  def profile_complete?
    self.educations.present? && self.experiences.present? && self.location && self.birthday
  end
end
