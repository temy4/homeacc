json.array!(@counterparties) do |counterparty|
  json.extract! counterparty, :id, :counterparty_name
  json.url counterparty_url(counterparty, format: :json)
end
