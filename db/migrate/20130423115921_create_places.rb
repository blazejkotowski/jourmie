class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.date :date_from
      t.date :date_to
      t.integer :album_id
      t.string :name
      t.integer :road_from_id
      t.integer :road_to_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
