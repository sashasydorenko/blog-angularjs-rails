class AddDescToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :desc, :text
  end
end
