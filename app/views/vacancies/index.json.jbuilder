json.array!(@vacancies) do |vacancy|
  json.extract! vacancy, :id, :title, :description
  json.url vacancy_url(vacancy, format: :json)
end
