class AddCategoriesToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :category, :string, :default => "text"
  end
end
