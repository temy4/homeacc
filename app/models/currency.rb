class Currency < ActiveRecord::Base
	has_many :cards
end
