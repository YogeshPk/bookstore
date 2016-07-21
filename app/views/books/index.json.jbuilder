json.array!(@books) do |book|
  json.extract! book, :id, :name, :description, :picture, :user_id
  json.url book_url(book, format: :json)
end
