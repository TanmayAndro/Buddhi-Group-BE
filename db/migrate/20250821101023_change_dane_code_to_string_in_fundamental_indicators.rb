class ChangeDaneCodeToStringInFundamentalIndicators < ActiveRecord::Migration[7.1]
  def change
    change_column :fundamental_indicators, :dane_code, :string
  end
end
