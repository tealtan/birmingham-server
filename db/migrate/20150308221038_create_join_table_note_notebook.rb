class CreateJoinTableNoteNotebook < ActiveRecord::Migration
  def change
    create_join_table :notes, :notebooks do |t|
      t.index [:note_id, :notebook_id]
      t.index [:notebook_id, :note_id]
    end
  end
end
