class UaClass < ApplicationRecord

  belongs_to :municipality
  has_many :rural_sectors
end
