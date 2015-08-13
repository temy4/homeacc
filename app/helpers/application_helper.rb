# encoding: utf-8
module ApplicationHelper
	def month_name(month)
		months_list = [
			'январь', 'февраль', 'март', 'апрель',
			'май', 'июнь', 'июль', 'август',
			'сентябрь', 'октябрь', 'ноябрь', 'декабрь'
		]

		return months_list[month - 1]
	end
end