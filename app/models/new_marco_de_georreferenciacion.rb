class NewMarcoDeGeorreferenciacion < ApplicationRecord

	self.table_name = :new_marco_de_georreferenciacions

	enum :unit_info, { "Municipal Headquarters"=> 1, "Populated Center"=> 2, "Rural Dispersed"=> 3, "Rest Rural (2 and 3)"=> 4}, prefix: :marco_unit_info
end
