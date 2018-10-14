class Company < ApplicationRecord
  mount_uploader :logo, LogoUploader
  
  belongs_to :employer
  has_many :jobs, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :jobhunter, through: :follows
  has_many :company_timelines
end
