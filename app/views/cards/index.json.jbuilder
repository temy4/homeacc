json.array!(@cards) do |card|
  json.extract! card, :id, :cc_type, :number_short, :number_full, :month_end, :year_end, :owner, :alias, :is_active
  json.url card_url(card, format: :json)
end
