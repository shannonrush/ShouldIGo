class AddUnitsToElements < ActiveRecord::Migration
  def change
    add_column :elements, :units, :string
  end
end
