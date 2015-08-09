json.array!(@taxes) do |tax|
  json.extract! tax, :id, :name, :percent, :desc
  json.url tax_url(tax, format: :json)
end
