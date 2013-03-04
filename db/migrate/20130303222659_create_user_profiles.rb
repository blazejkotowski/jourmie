class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.integer :user_id
      t.string :name
      t.string :surname
      t.string :sex
      t.string :phone
      t.date :birthday

      t.timestamps
    end
  end
end
