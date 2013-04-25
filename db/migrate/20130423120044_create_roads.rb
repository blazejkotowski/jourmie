class CreateRoads < ActiveRecord::Migration
  def change
    create_table :roads do |t|
      t.belongs_to :place_from
      t.belongs_to :place_to
      t.integer :album_id

      t.timestamps
    end
  end
end
