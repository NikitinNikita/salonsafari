json.array!(@sales) do |sale|
  json.extract! sale, :id, :title, :description
  json.url sale_url(sale, format: :json)
end
