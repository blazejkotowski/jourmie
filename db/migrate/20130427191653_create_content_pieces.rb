class CreateContentPieces < ActiveRecord::Migration
  def change
    create_table :content_pieces do |t|
      t.string :type
      t.string :file
      t.belongs_to :place
      t.belongs_to :user
      t.string :description

      t.timestamps
    end
    add_index :content_pieces, :place_id
  end
end
