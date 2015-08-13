# encoding: utf-8
class Card < ActiveRecord::Base
	belongs_to :currency
	validate :check_currency
	validate :check_card_number

	after_validation(:on => :create) do
		# self.card_number = self.card_number.gsub!(/^(\d{6})\d+(\d{4})$/, '\1******\2')
	end

	def check_currency
		if currency_id.nil? or not Currency.exists?(currency_id)
			errors.add('Валюта', 'введена неверно')
			errors[:state] = 'nok';
		end
	end

	def check_card_number
		unless card_number.nil? or card_number.empty?
			number = card_number
			number = number.gsub(' ', '')
			number = number.gsub('-', '')
	
			doubled  = ""
			result = 0
	
			step = number.length%2
	
			number.split(//).each_with_index do |digit, index|
				if index.to_i % 2 == step
					doubled = (digit.to_i * 2).to_s
					p digit
				else
					doubled.split(//).each do |f|
						result += f.to_i
					end
					result += digit.to_i
				end
			end

			masked = number.length - 10
			self.card_number = number.gsub(/.(?=....)/, '*')

			unless result % 10 == 0
				errors.add('Ошибка', 'в номере карты')
				errors[:state] = 'nok';
			end
		else
			errors.add('Номер карты', 'не указан')
			errors[:state] = 'nok';
		end
	end
end
