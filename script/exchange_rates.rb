# encoding: utf-8
require 'nokogiri'
require 'open-uri'
require 'date'

require '/home/temy4/Projects/homeacc/config/environment.rb'
# require '../config/environment.rb'

url = "http://www.cbr.ru/scripts/XML_daily.asp?date_req=#{Time.new.strftime("%d.%m.%Y")}"
xml = Nokogiri::XML(open(url))
rates = xml.xpath("//ValCurs/Valute")

if rates.size > 0

	connection = ActiveRecord::Base.connection
	connection.execute("TRUNCATE TABLE `currencies`")

    cur = Currency.new
    cur.cbr_num = '000'
    cur.name = 'Российскийский рубль'
    cur.sign = 'RUB'
    cur.currency_count = '1'
    cur.rate = 1
    cur.save

	rates.each do |rate|
	    id = rate.css('NumCode').children.first
	    name = rate.css('Name').children.first
	    sign = rate.css('CharCode').children.first
	    nom = rate.css('Nominal').children.first
	    val = rate.css('Value').children.first
	    
	    cur = Currency.new
	    cur.cbr_num = id
	    cur.name = name
	    cur.sign = sign
	    cur.currency_count = nom.to_s
	    cur.rate = val.to_s.sub! ',', '.'
	    cur.save
	end
end