class CategoriesGroup < ActiveRecord::Base
	validates :alias, presence: true
	
	validate :check_existed
	has_and_belongs_to_many :unit_categories

	def is_deleted?
	          is_active == 0
	end

	def check_existed
		unless id.nil? 
			db_value = CategoriesGroup.find(id).alias
			unless self.alias == db_value
				existed_in_db?
			end
		else
			existed_in_db?
		end
	end

	def existed_in_db?
		if CategoriesGroup.where(:alias => self.alias, :is_active => 1).size > 0
			errors.add('Группа категорий', "уже существует")
			errors[:state] = 'nok';
		end

		if CategoriesGroup.where(:alias => self.alias, :is_active => 0).size > 0
			errors.add('Группа категорий', "была ранее удалена")
			existed = CategoriesGroup.where(:alias => self.alias, :is_active => 0).first.id
			errors[:state] = 'ok';
			errors[:rollback] = "/categories_groups/#{existed.to_s}/recover";
		end
	end
end
