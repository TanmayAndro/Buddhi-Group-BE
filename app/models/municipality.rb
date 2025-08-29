class Municipality < ApplicationRecord
  belongs_to :department
  has_many :ua_classes
end
