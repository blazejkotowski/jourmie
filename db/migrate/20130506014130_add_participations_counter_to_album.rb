class AddParticipationsCounterToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :participations_count, :integer, :default => 0
    
    Album.reset_column_information
    Album.find_each do |album|
      Album.reset_counters album.id, :participations
    end
  end
end
