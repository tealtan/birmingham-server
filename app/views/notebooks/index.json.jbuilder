json.array!(@notebooks) do |notebook|
  json.extract! notebook, :id, :name, :description, :active
  json.url notebook_url(notebook, format: :json)
end
