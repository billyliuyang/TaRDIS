class AddStaffgivennameToStaffs < ActiveRecord::Migration[5.0]
  def change
    add_column :staffs, :staffgivenname, :string
  end
end
