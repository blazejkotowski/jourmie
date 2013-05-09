class AddLikesCountToContentPiece < ActiveRecord::Migration
  def change
    add_column :content_pieces, :likes_count, :integer, :default => 0
  end
end
