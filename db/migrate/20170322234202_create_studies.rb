class CreateStudies < ActiveRecord::Migration[5.0]
  def change
    create_table :studies do |t|
      t.string :title
      t.date :startdate
      t.date :enddate
      t.text :description

      t.timestamps
    end
  end
end
