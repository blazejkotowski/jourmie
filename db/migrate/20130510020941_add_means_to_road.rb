class AddMeansToRoad < ActiveRecord::Migration
  def change
    add_column :roads, :means, :integer
  end
end
