json.array!(@comments) do |comment|
  json.extract! comment, :id, :name, :email, :message, :message_date
  json.url comment_url(comment, format: :json)
end
