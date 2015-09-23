class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :url
      t.references :tag, index: true
      t.integer :dangerous

      t.timestamps
    end
  end
end
