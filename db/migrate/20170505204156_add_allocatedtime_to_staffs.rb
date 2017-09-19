class AddAllocatedtimeToStaffs < ActiveRecord::Migration[5.0]
  def change
    add_column :staffs, :allocatedtime, :integer, default: 0
  end
end
