class RemoveTypesFromNotes < ActiveRecord::Migration
  def change
    remove_column :notes, :types, :string
  end
end
