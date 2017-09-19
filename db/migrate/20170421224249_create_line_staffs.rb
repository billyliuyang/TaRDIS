class CreateLineStaffs < ActiveRecord::Migration[5.0]
  def change
    create_table :line_staffs do |t|
      t.references :staff, foreign_key: true
      t.belongs_to :task, foreign_key: true

      t.timestamps
    end
  end
end
