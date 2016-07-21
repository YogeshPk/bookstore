json.array!(@coauthors) do |coauthor|
  json.extract! coauthor, :id, :user_id, :book_id
  json.url coauthor_url(coauthor, format: :json)
end
