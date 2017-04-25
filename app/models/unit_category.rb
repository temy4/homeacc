class UnitCategory < ActiveRecord::Base
	validates :name, presence: true
	
	validate :check_existed

	belongs_to :counterparty
	belongs_to :tax
	has_and_belongs_to_many :categories_groups

	def is_deleted?
		is_active == 0
	end

	def check_existed
		unless id.nil? 
			db_value = UnitCategory.find(id).name
			unless name == db_value
				existed_in_db?
			end
		else
			existed_in_db?
		end
	end

	def existed_in_db?
		if UnitCategory.where(:name => name, :is_active => 1).size > 0
			errors.add('Категория', "уже существует")
			errors[:state] = 'nok';
		end

		if UnitCategory.where(:name => name, :is_active => 0).size > 0
			errors.add('Категория', "была ранее удалена")
			existed = UnitCategory.where(:name => name, :is_active => 0).first.id
			errors[:state] = 'ok';
			errors[:rollback] = "/unit_categories/#{existed.to_s}/recover";
		end
	end

end
