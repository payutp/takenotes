class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :text
      t.integer :x
      t.integer :y
      t.integer :width
      t.integer :height
      t.integer :folder_id
      t.timestamps
    end
  end
end
