class RuralSection < ApplicationRecord
  belongs_to :rural_sector
  has_many :populated_centers
end
