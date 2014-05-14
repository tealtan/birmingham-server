class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title
      t.text :content
      t.string :types, array: true, default: []
      t.hstore :metadata
      t.boolean :archived

      t.timestamps
    end
  end
end
