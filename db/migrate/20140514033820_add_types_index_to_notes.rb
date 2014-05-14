class AddTypesIndexToNotes < ActiveRecord::Migration
  def change
    add_index :notes, :types, using: 'gin'
  end
end
