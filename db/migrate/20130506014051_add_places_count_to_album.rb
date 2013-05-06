class AddPlacesCountToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :places_count, :integer, :default => 0
    
    Album.reset_column_information
    Album.find_each do |album|
      Album.reset_counters album.id, :places
    end
  end
end
