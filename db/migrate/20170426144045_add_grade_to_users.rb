class AddGradeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :grade, :integer
  end
end
