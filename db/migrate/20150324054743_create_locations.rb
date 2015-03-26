class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.text :description
      t.text :features, array: true, default: []
      t.float :loc, array: true, default: []

      t.timestamps null: false
    end
  end
end
