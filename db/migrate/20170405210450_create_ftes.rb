class CreateFtes < ActiveRecord::Migration[5.0]
  def change
    create_table :ftes do |t|
      t.string :FTE_value
      t.date :startdate
      t.date :enddate
      t.belongs_to :staff, foreign_key: true

      t.timestamps
    end
  end
end
