# encoding: utf-8
class Tax < ActiveRecord::Base
	validates :name, presence: true
	validate :check_existed
  
  def is_deleted?
    is_active == 0
  end

  def check_existed
  	unless id.nil? 
  		db_value = Tax.find(id).name
  		unless name == db_value
  			existed_in_db?
  		end
  	else
  		existed_in_db?
  	end
  end

  def existed_in_db?
  	if Tax.where(:name => name, :is_active => 1).size > 0
  		errors.add('Налог', "уже существует")
  		errors[:state] = 'nok';
  	end

  	if Tax.where(:name => name, :is_active => 0).size > 0
  		errors.add('Налог', "был ранее удален")
  		existed = Tax.where(:name => name, :is_active => 0).first.id
  		errors[:state] = 'ok';
  		errors[:rollback] = "/taxes/#{existed.to_s}/recover";
  	end
  end
end
