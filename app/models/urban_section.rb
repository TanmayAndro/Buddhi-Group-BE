class UrbanSection < ApplicationRecord
  belongs_to :urban_sector
  has_many :fundamental_indicators
end
