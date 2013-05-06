class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.belongs_to :album
      t.belongs_to :user

      t.timestamps
    end
    add_index :participations, :album_id
    add_index :participations, :user_id
  end
end
