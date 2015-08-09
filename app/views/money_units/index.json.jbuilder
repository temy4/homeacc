json.array!(@money_units) do |money_unit|
  json.extract! money_unit, :id, :counterparty_id, :currency_id, :tax_id, :type, :name, :period, :current_period_price, :next_period_price, :current_period, :next_period, :is_active
  json.url money_unit_url(money_unit, format: :json)
end
