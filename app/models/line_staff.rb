# == Schema Information
#
# Table name: line_staffs
#
#  id         :integer          not null, primary key
#  staff_id   :integer
#  task_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  grade      :integer
#
# Indexes
#
#  index_line_staffs_on_staff_id  (staff_id)
#  index_line_staffs_on_task_id   (task_id)
#
# Foreign Keys
#
#  fk_rails_78671a64a0  (staff_id => staffs.id)
#  fk_rails_c3d405e356  (task_id => tasks.id)
#

class LineStaff < ApplicationRecord
  belongs_to :staff
  belongs_to :task
end
