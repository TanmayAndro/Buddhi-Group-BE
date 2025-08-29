class RuralSector < ApplicationRecord
  belongs_to :ua_class
  has_many :rural_sections
end
