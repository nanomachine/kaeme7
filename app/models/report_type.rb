class ReportType < ActiveRecord::Base
	has_many :problems

  	attr_accessible :category, :name
	validates(:name, presence: true, uniqueness: true)

end
