json.array!(@categories_groups) do |categories_group|
  json.extract! categories_group, :id, :unit_category_id, :alias, :is_active
  json.url categories_group_url(categories_group, format: :json)
end
