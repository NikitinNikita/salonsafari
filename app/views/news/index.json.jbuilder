json.array!(@news) do |news|
  json.extract! news, :id, :title, :description, :image_path
  json.url news_url(news, format: :json)
end
