class AddRoadIdToContentPiecie < ActiveRecord::Migration
  def change
    add_column :content_pieces, :road_id, :integer
  end
end
