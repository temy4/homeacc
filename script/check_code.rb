number = "4417123456789113"
number = number.gsub(' ', '')
number = number.gsub('-', '')

doubled  = ""
result = 0

number.split(//).each_with_index do |digit, index|
	if index.to_i % 2 == 0
		doubled = (digit.to_i * 2).to_s
		p digit
	else
		doubled.split(//).each do |f|
			result += f.to_i
		end
		result += digit.to_i
	end
end

if result % 10 == 0
	p (result/10).to_s + ": Valid"
else
	p (result.to_f/10.to_f).to_s + ": Invalid"
end