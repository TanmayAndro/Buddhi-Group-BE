class PopulatedCenter < ApplicationRecord
  belongs_to :rural_section
  has_many :urban_sectors
end
