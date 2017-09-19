class AddYearToTimeManagement < ActiveRecord::Migration[5.0]
  def change
    add_column :time_managements, :year, :integer
  end
end
