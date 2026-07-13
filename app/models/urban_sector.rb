class UrbanSector < ApplicationRecord
	belongs_to :populated_center
	has_many :urban_sections
end
