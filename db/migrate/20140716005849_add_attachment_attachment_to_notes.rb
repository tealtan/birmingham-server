class AddAttachmentAttachmentToNotes < ActiveRecord::Migration
  def self.up
    change_table :notes do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :notes, :attachment
  end
end
