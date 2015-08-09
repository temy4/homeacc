json.array!(@unit_categories) do |unit_category|
  json.extract! unit_category, :id, :name
  json.url unit_category_url(unit_category, format: :json)
end
