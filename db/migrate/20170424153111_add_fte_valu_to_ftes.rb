class AddFteValuToFtes < ActiveRecord::Migration[5.0]
  def change
  	add_column :ftes, :FTE_value, :integer
  end
end
