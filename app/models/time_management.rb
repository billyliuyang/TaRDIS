# == Schema Information
#
# Table name: time_managements
#
#  id         :integer          not null, primary key
#  chart_year :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  year       :integer
#

class TimeManagement < ApplicationRecord
	before_create do
		self.year = Date.current.year
	end
end
