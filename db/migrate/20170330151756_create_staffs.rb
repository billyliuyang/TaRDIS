class CreateStaffs < ActiveRecord::Migration[5.0]
  def change
    create_table :staffs do |t|
      t.string :name
      t.integer :grade
      t.date :startdate
      t.date :enddate
      t.string :FTE

      t.timestamps
    end
  end
end
