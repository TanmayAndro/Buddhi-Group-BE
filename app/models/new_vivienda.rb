class NewVivienda < ApplicationRecord
	self.table_name = :new_viviendas

	enum :unit_info, { "Municipal Headquarters"=> 1, "Populated Center"=> 2, "Rural Dispersed"=> 3, "Rest Rural (2 and 3)"=> 4 }, prefix: :viv_unit_info

	enum :ethnic_territory_type, { "Indigenous Reservation"=> 1, "Collective Territory of the Black Community"=> 2 }, prefix: :viv_ethnic_territory_type

	enum :home_usage, { "Housing" => 1, "Mixed (Independent and separate space that combines housing with another non-residential use)" => 2, "NON-Residential Unit (Independent and separate space for use <> housing)" => 3, "Special Place of Accommodation - LEA" => 4 }, prefix: :viv_home_usage


	enum :house_type, { "House" => 1, "Apartment" => 2, "Fourth type" => 3, "Traditional Indigenous housing" => 4, "Traditional Ethnic Housing (Afro-Colombian, Islander, Rrom)" => 5, "Other (container, tent, boat, wagon, cave, natural shelter, etc.)" => 6 }, prefix: :viv_house_type

	enum :houses_occupation, { "Busy with people present" => 1, "Busy with all the people absent" => 2, "Temporary housing (for vacations, work, etc.)" => 3, "Unoccupied" => 4 }, prefix: :viv_houses_occupation

	enum :contruction_material, { "Block, brick, stone, polished wood" => 1, "poured concrete" => 2, "prefabricated material" => 3, "Guadua" => 4, "Stepped wall, bahareque, adobe" => 5, "rough wood, board, plank" => 6, "Cane, mat, other vegetables" => 7, "Waste materials (Zinc, fabric, cardboard, cans, plastics, others)" => 8, "It doesn't have walls" => 9 }, prefix: :viv_contruction_material

	enum :socioeconomic_status, { "Without Stratum" => 0, "Stratum 1" => 1, "Stratum 2" => 2, "Stratum 3" => 3, "Stratum 4" => 4, "Stratum 5" => 5, "Stratum 6" => 6, "Does not know the stratum" => 9 }, prefix: :viv_socioeconomic_status

	enum :gas_availability, { "Yes"=> 1, "No"=> 2, "Does not report"=> 9 }, prefix: :viv_gas_availability

	enum :garbage_disposability, { "Yes"=> 1, "No"=> 2, "Does not report"=> 9 }, prefix: :viv_garbage_disposability

	enum :disposal_frequency, { "1 Time"=> 1, "2 Times"=> 2, "3 Times"=> 3, "4 Times"=> 4, "5 Times"=> 5, "6 Times"=> 6, "7 Times"=> 7, "Greater periodicity"=> 8, "Does not know"=> 9 }, prefix: :viv_disposal_frequency

	enum :sanitory_quality, { "Toilet connected to sewer?" => 1, "Toilet connected to septic tank?" => 2, "Toilet without connection?" => 3, "Latrine?" => 4, "Toilet with direct discharge to water sources (low tide)?" => 5, "Does this home not have sanitary service?" => 6 }, prefix: :viv_sanitory_quality

	enum :house_category, { "Penitentiary center" => 1, "Institution of protection and preventive boarding school for boys, girls and adolescents" => 2, "Protection and care center for the elderly" => 3, "Convent, seminary, monastery or other similar institutions" => 4, "Educational headquarters with internal population" => 5, "Barracks, military garrison (Army, Navy and Air Force)" => 6, "police command, police station" => 7, "Labor camp" => 8, "Lenocinium or brothel" => 9, "Displaced people's shelter" => 10, "Home of peace" => 11, "Functional rehabilitation center" => 12, "indigenous passage house" => 13, "does not apply" => 14 }, prefix: :viv_house_category

	enum :home_availability, { "Yes" => 1, "No" => 2, "Not Applicable" => 4, "Does not inform" => 9 }, prefix: :viv_home_availability

	enum :is_protected_area, { "Yes" => 1, "No" => 2, "Not Applicable" => 4, "Does not inform" => 9 }, prefix: :viv_is_protected_area
end
