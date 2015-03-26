class RemoveFeaturesFromLocations < ActiveRecord::Migration
  def change
    remove_column :locations, :features, :text
  end
end
