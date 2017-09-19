class CreateTimeManagements < ActiveRecord::Migration[5.0]
  def change
    create_table :time_managements do |t|
      t.decimal :chart_year

      t.timestamps
    end
  end
end
