class RemoveFteValueFromFtes < ActiveRecord::Migration[5.0]
  def change
  	remove_column :ftes, :FTE_value, :string
  end
end
