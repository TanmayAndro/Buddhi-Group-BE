class Fallecido < ApplicationRecord
	self.table_name = :fallecidos

	enum :unit_info, { "Municipal Headquarters": 1, "Populated Center": 2, "Rural Dispersed": 3, "Rest Rural (2 and 3)": 4}, prefix: :fal_unit_info

	enum :death_count, { "00 Persons": 0, "01 Person": 1, "02 Persons": 2, "03 Persons": 3, "04 Persons": 4, "05 Persons": 5, "06 Persons": 6, "07 Persons": 7, "08 Persons": 8, "09 Persons": 9, "10 Persons": 10, "11 Persons": 11, "12 Persons": 12, "13 Persons": 13, "14 Persons": 14, "15 Persons": 15, "16 Persons": 16, "17 Persons": 17, "18 Persons": 18, "19 Persons": 19, "20 Persons": 20 }, prefix: :fal_death_count

	enum :gender_indicator, { "Man": 1, "Woman": 2, "Does not report": 9 }, prefix: :fal_gender_indicator

end