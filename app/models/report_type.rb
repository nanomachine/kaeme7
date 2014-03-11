class ReportType < ActiveRecord::Base
	has_and_belongs_to_many :problems

  	attr_accessible :category, :name
	validates(:name, presence: true, uniqueness: true)

end
