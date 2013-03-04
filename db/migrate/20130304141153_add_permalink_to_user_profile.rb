class AddPermalinkToUserProfile < ActiveRecord::Migration
  def change
    add_column :user_profiles, :permalink, :string
  end
end
