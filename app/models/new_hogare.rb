class NewHogare < ApplicationRecord
	self.table_name = :new_hogares

	enum :unit_info, { "Municipal Headquarters" => 1, "Populated Center" => 2, "Rural Dispersed" => 3, "Rest Rural (2 and 3)" => 4 },  prefix: :hog_unit_info

	enum :rooms_count, { "1 rooms" => 1, "2 rooms" => 2, "3 rooms" => 3, "4 rooms" => 4, "5 rooms" => 5, "6 rooms" => 6, "7 rooms" => 7, "8 rooms" => 8, "9 rooms" => 9, "10 rooms" => 10, "11 rooms" => 11, "12 rooms" => 12, "13 rooms" => 13, "14 rooms" => 14, "15 rooms" => 15, "16 rooms" => 16, "17 rooms" => 17, "18 rooms" => 18, "19 rooms" => 19, "20 rooms" => 20, "Does not inform" => 99 },  prefix: :hog_rooms_count

	enum :bedroom_count, { "1 rooms" => 1, "2 rooms" => 2, "3 rooms" => 3, "4 rooms" => 4, "5 rooms" => 5, "6 rooms" => 6, "7 rooms" => 7, "8 rooms" => 8, "9 rooms" => 9, "10 rooms" => 10, "11 rooms" => 11, "12 rooms" => 12, "13 rooms" => 13, "14 rooms" => 14, "15 rooms" => 15, "16 rooms" => 16, "17 rooms" => 17, "18 rooms" => 18, "19 rooms" => 19, "20 rooms" => 20, "Does not inform" => 99 },  prefix: :hog_bedroom_count

	enum :kitchen_area, { "In a room used only for cooking?" => 1, "In a room also used for sleeping?" => 2, "In a living-dining room with a dishwasher?" => 3, "In a living-dining room without a dishwasher?" => 4, "In a patio, corridor, bower or outdoors?" => 5, "Do they not prepare food in the home?" => 6, "Does not report" => 9 },  prefix: :hog_kitchen_area

	enum :water_source, { "Public aqueduct?" => 1, "Village aqueduct?" => 2, "Community distribution network?" => 3, "Well with pump?" => 4, "Well without pump, cistern, jaguey or auger?" => 5, "Water rain?" => 6, "River, stream, spring, source?" => 7, "Public stack?" => 8, "Tank car?" => 9, "Aguatero?" => 10, "Bottled or bagged water?" => 11, "They don't prepare food" => 12, "No informa" => 99 },  prefix: :hog_water_source

	enum :death_2017, { "00 Persons" => 0, "01 Person" => 1, "02 Persons" => 2, "03 Persons" => 3, "04 Persons" => 4, "05 Persons" => 5, "06 Persons" => 6, "07 Persons" => 7, "08 Persons" => 8, "09 Persons" => 9, "10 Persons" => 10, "11 Persons" => 11, "12 Persons" => 12, "13 Persons" => 13, "14 Persons" => 14, "15 Persons" => 15, "16 Persons" => 16, "17 Persons" => 17, "18 Persons" => 18, "19 Persons" => 19, "20 Persons" => 20 }, prefix: :hog_death_2017 

end
