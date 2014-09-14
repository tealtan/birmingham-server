json.array!(@notes) do |note|
  json.extract! note, :id, :title, :content, :category, :metadata, :archived
  json.url note_url(note, format: :json)
end
