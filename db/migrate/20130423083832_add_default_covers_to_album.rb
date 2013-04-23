class AddDefaultCoversToAlbum < ActiveRecord::Migration
  def change
    rename_column :albums, :cover_image, :custom_cover_image
    add_column :albums, :jourmie_cover_image, :integer, :default => 1
  end
end
