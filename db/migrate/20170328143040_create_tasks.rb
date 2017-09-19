class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.date :startdate
      t.date :enddate
      t.integer :lead_dm_time
      t.integer :dm_time
      t.integer :support_dm_time
      t.belongs_to :study, foreign_key: true

      t.timestamps
    end
  end
end
