class FundamentalIndicator < ApplicationRecord
  self.table_name = :fundamental_indicators

  belongs_to :urban_section, optional: true
  belongs_to :new_marco_de_georreferenciacion, class_name: "NewMarcoDeGeorreferenciacion", foreign_key: "new_marco_de_georreferenciacion_id", optional: true
end
