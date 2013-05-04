class AddFriendsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :friends_count, :integer, :default => 0
  end
end
