class CreatePictureTags < ActiveRecord::Migration
  def change
    create_table :picture_tags do |t|
      t.references :picture, null: false, index: true
      t.references :tag, null: false, index: true

      t.timestamps
    end

    add_index :picture_tags, [:picture_id, :tag_id], :unique => true
  end
end
