class ChangeUserProfileFieldsToOmniAuthFields < ActiveRecord::Migration
  def change
    rename_column :user_profiles, :name, :first_name
    rename_column :user_profiles, :surname, :last_name
  end
end
