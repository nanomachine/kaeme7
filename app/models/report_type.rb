class ReportType < ActiveRecord::Base
	has_and_belongs_to_many :problems

  	attr_accessible :category, :name
	validates(:name, presence: true, uniqueness: true)

	# Where to store the report_type marker depending on the environment
  if Rails.env.production?
    has_attached_file :avatar, :styles => {:thumb => "32x37#"},
          :path => ":rails_root/public/assets/report_types/:id/:style/:basename.:extension",
                    :storage => :s3,
          :url => "/assets/report_types/:id/:style/:basename.:extension",  
          :s3_credentials => "#{Rails.root}/config/s3.yml",
          :bucket => "kaeme7";
  else
    has_attached_file :avatar, :styles => {:thumb => "32x37#"},
          :path => ":rails_root/public/assets/report_types/:id/:style/:basename.:extension",
          :url => "/assets/report_types/:id/:style/:basename.:extension";
  end

end
