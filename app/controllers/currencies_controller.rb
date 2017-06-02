# encoding: utf-8
class CurrenciesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_currency, only: [:show, :edit, :update, :destroy]

  # GET /currencies
  # GET /currencies.json
  def index
    @currencies = Currency.where('cbr_num NOT IN ("000", "960")')
  end

  def update_all
    require 'nokogiri'
    require 'open-uri'

    url = "http://www.cbr.ru/scripts/XML_daily.asp?date_req=#{Time.new.strftime("%d.%m.%Y")}"
    xml = Nokogiri::XML(open(url))
    rates = xml.xpath("//ValCurs/Valute")

    respond_to do |format|
      if rates.size > 0

        connection = ActiveRecord::Base.connection
        connection.execute("TRUNCATE TABLE `currencies`")

          cur = Currency.new
          cur.cbr_num = '000'
          cur.name = 'Российский рубль'
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
        format.html { redirect_to currencies_url, flash: { notice: 'Курсы валют были обновлены', type: 'updated', state: 'ok' } }
      else
        format.html { redirect_to currencies_url, flash: { notice: 'Ошибка обновления курсов валют', type: 'updated', state: 'nok' } }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_currency
      @currency = Currency.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def currency_params
      params.require(:currency).permit(:name, :sign)
    end
end
