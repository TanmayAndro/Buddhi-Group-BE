class RemoveNewMarcoDeGeorreferenciacionFromFundamentalIndicators < ActiveRecord::Migration[7.1]
  def change
    remove_reference :fundamental_indicators, :new_marco_de_georreferenciacion, foreign_key: true, index: true
  end
end
