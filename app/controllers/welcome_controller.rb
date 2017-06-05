class WelcomeController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  def index
    @chart_data = [['Месяц', 'Приход', 'Расход', 'Баланс']]
    raw_data = VMoneyUnitsMonthlyTotal.where(:year => Time.current.year).order(:month)
    total = 0;
    raw_data.each do |row|
      ins = 0
      outs = 0
      unless row.ins.nil?
        ins = row.ins.truncate(2).to_f
      end
      unless row.outs.nil?
        outs = row.outs.truncate(2).to_f
      end
      total = total + ins - outs
      @chart_data.push([
        month_name(row.month),
        ins,
        outs,
        total
      ])
    end
  end
end
