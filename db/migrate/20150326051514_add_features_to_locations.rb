class AddFeaturesToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :feature24hr, :boolean
    add_column :locations, :featurePower, :boolean
    add_column :locations, :featureSeating, :boolean
  end
end
