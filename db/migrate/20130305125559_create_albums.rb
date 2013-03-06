class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.integer :user_id
      t.date :start_date
      t.date :end_date
      t.string :cover_image

      t.timestamps
    end
  end
end
