class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commentable_id
      t.string :commentable_type
      t.string :text
      t.integer :user_id

      t.timestamps
    end
    add_column :content_pieces, :comments_count, :integer, :default => 0
  end
end
