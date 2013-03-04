class RemoveImageFromUserProfile < ActiveRecord::Migration
  def up
    remove_column :user_profiles, :image
  end

  def down
    add_column :user_profiles, :image, :string
  end
end
