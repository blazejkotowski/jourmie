class CreateRoads < ActiveRecord::Migration
  def change
    create_table :roads do |t|
      t.integer :place_from_id
      t.integer :place_to_id
      t.integer :album_id

      t.timestamps
    end
  end
end
