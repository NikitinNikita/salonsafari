class AddCoverToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :cover, :string
  end
end
