class MoneyUnit < ActiveRecord::Base
          belongs_to :unit_category
          belongs_to :tax
          belongs_to :currency
          belongs_to :counterparty

          validates :unit_category_id, :transaction_type, :transaction_date, :currency_id, presence: true

          validates :starting_amount, presence: { if: -> { planned_amount.blank? } }
          validates :planned_amount, presence: { if: -> { starting_amount.blank? } }

          def starting_amount=(val)
            write_attribute(:starting_amount, val.sub(',', '.'))
          end

          def planned_amount=(val)
            write_attribute(:planned_amount, val.sub(',', '.'))
          end
end
