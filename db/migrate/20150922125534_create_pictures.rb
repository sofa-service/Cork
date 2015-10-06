class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :url, :null => false
      t.references :tag, index: true
      t.integer :dangerous, :null => false, :default => 0

      t.timestamps
    end
  end
end
