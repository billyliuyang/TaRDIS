# == Schema Information
#
# Table name: ftes
#
#  id         :integer          not null, primary key
#  startdate  :date
#  enddate    :date
#  staff_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  FTE_value  :integer
#
# Indexes
#
#  index_ftes_on_staff_id  (staff_id)
#
# Foreign Keys
#
#  fk_rails_aeea50576d  (staff_id => staffs.id)
#

class Fte < ApplicationRecord
  belongs_to :staff
  validate :value_validate
  validate :start_date_before_end_date
  validate :new_fte_date

  def value_validate
  	if self.FTE_value.nil?
  		errors.add(:error, ": FTE value should not be empty")
    elsif self.FTE_value < 0 || self.FTE_value > 100
      errors.add(:error, ": FTE value should be in the range from 0 to 100")
    end
  end

  def start_date_before_end_date
    if self.startdate.nil? || self.enddate.nil?
      errors.add(:error, ": date cannot be empty")
  	elsif self.startdate > self.enddate
    	errors.add(:error, ": start date cannot be before the end date")
  	end
  end

  def new_fte_date
    fte = Fte.where(staff_id: staff.id)
    fte.each do |fte|
      if self.startdate.nil? || self.enddate.nil?
        errors.add(:error, ": date cannot be empty")
      elsif (self.startdate.month <= fte.enddate.month && self.startdate.month >= fte.startdate.month) ||
        (self.enddate.month <= fte.enddate.month && self.enddate.month >= fte.startdate.month)
        errors.add(:error, ": new FTE start date should be after previous FTE end date")
      end
    end
  end
end
