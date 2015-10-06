class RemoveTagIdFromPictures < ActiveRecord::Migration
  def change
    remove_column :pictures, :tag_id, :integer
  end
end
