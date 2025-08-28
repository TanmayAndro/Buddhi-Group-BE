class AddReferenceInFundamentalIndicator < ActiveRecord::Migration[7.1]
  def change
        add_reference :fundamental_indicators, :new_marco_de_georreferenciacion, foreign_key: true
  end
end
