class MoneyUnit < ActiveRecord::Base
          belongs_to :unit_category
          belongs_to :tax
          belongs_to :currency
          belongs_to :counterparty
end
