# encoding: utf-8
class Card < ActiveRecord::Base
	validate :check_card_number

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
			card_number = card_number.to_s.gsub(/^(\d{6})\d+(\d{4})$/, '\1******\2')

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
