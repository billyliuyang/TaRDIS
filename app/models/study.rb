# == Schema Information
#
# Table name: studies
#
#  id          :integer          not null, primary key
#  title       :string
#  startdate   :date
#  enddate     :date
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Study < ApplicationRecord
	validate :start_date_before_end_date
	validate :title_empty
	has_many :tasks, dependent: :destroy
  
  	def start_date_before_end_date
    	if self.startdate > self.enddate
      		errors.add(:error, ": Start date should be before the end date")
    	end
  	end

  	def title_empty
  		if self.title.empty?
  			errors.add(:error, ": Study title should not be empty")
  		end
  	end

end
