class AddGradeToLineStaffs < ActiveRecord::Migration[5.0]
  def change
    add_column :line_staffs, :grade, :integer
  end
end
