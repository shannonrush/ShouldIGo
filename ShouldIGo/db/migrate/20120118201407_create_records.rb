class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :station
      t.references :element
      t.integer :year
      t.integer :month
      t.integer :day
      t.integer :value
      t.timestamps
    end
  end
end
