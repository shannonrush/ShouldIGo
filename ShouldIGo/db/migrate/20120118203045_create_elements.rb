class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
      t.string :code

      t.timestamps
    end
  end
end
