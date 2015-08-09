# encoding: utf-8
class Counterparty < ActiveRecord::Base
	validates :counterparty_name, presence: true
	validate :check_existed
  
  def is_deleted?
    is_active == 0
  end

  def check_existed
  	unless id.nil? 
  		db_value = Counterparty.find(id).counterparty_name
  		unless counterparty_name == db_value
  			existed_in_db?
  		end
  	else
  		existed_in_db?
  	end
  end

  def existed_in_db?
  	if Counterparty.where(:counterparty_name => counterparty_name, :is_active => 1).size > 0
  		errors.add('Контрагент', "уже существует")
  		errors[:state] = 'nok';
  	end

  	if Counterparty.where(:counterparty_name => counterparty_name, :is_active => 0).size > 0
  		errors.add('Контрагент', "был ранее удален")
  		existed = Counterparty.where(:counterparty_name => counterparty_name, :is_active => 0).first.id
  		errors[:state] = 'ok';
  		errors[:rollback] = "/counterparties/#{existed.to_s}/recover";
  	end
  end

end
