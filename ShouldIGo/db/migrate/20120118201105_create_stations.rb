class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :code
      t.decimal :lat, :precision => 15, :scale => 10
      t.decimal :lng, :precision => 15, :scale => 10

      t.timestamps
    end
  end
end
