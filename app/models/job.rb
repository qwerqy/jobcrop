class Job < ApplicationRecord
	belongs_to :company, counter_cache: true
	has_many :bookings, dependent: :destroy

	include PgSearch
	pg_search_scope :search_by_title, :against => [:title], :using => {:tsearch => {:any_word => true}}

	def location
    	"#{self.address} #{self.state} #{self.country} #{self.zipcode}"
 	end
end
