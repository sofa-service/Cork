class AddIndexPicturesUrl < ActiveRecord::Migration
  def change
    add_index :pictures, :url, :unique => true
  end
end
