# == Schema Information
#
# Table name: staffs
#
#  id             :integer          not null, primary key
#  name           :string
#  grade          :integer
#  startdate      :date
#  enddate        :date
#  FTE            :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  allocatedtime  :integer          default(0)
#  staffgivenname :string
#

class Staff < ApplicationRecord

  has_many :line_staffs, dependent: :destroy
  validate :name_empty
  validate :name_existing, on: :create
  validate :grade_empty
  has_many :ftes, dependent: :destroy

  def name_empty
  	if self.name.empty?
  		errors.add(:error, ": CiCS account cannot not be empty")
		end
  end

  def name_existing
    if Staff.exists?(name: self.name)
      errors.add(:error, ": User already exists")
    end  
  end

  def grade_empty
  	if self.grade.nil?
  		errors.add(:error, ": Grade cannot be empty")
		end
  end


end

