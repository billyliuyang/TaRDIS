# == Schema Information
#
# Table name: tasks
#
#  id              :integer          not null, primary key
#  title           :string
#  startdate       :date
#  enddate         :date
#  lead_dm_time    :integer
#  dm_time         :integer
#  support_dm_time :integer
#  study_id        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_tasks_on_study_id  (study_id)
#
# Foreign Keys
#
#  fk_rails_992bbe2d61  (study_id => studies.id)
#

class Task < ApplicationRecord
  belongs_to :study
  has_many :line_staffs, dependent: :destroy

  validate :start_date_before_end_date
  validate :title_empty
  validate :duration_staff
  validate :allocate_time

  def start_date_before_end_date
  	if self.startdate > self.enddate
    	errors.add(:error, ": Start date should be before the end date")
  	end
  end

  def title_empty
  	if self.title.empty?
  		errors.add(:error, ": Task title cannot be empty")
  	end
  end
  
  def duration_staff
    if self.lead_dm_time.nil?
      self.lead_dm_time = 0
    elsif self.lead_dm_time < 0
      errors.add(:error, ": Lead DM time should bigger than 0")
    end
    if self.dm_time.nil?
      self.dm_time = 0
    elsif self.dm_time < 0
      errors.add(:error, ": DM time should bigger than 0")
    end
    if self.support_dm_time.nil?
      self.support_dm_time = 0
    elsif self.support_dm_time < 0
      errors.add(:error, ": Support DM time should bigger than 0")
    end
  end

  def allocate_time
    if (self.enddate - self.startdate + 1).to_i * 24 < self.lead_dm_time ||
      (self.enddate - self.startdate + 1).to_i * 24 < self.dm_time ||
      (self.enddate - self.startdate + 1).to_i * 24 < self.support_dm_time
      errors.add(:error, ": Allocated time cannot be bigger than Task duration")
    end
  end


end
