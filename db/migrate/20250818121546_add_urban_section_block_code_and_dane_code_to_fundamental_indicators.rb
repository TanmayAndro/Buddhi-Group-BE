class AddUrbanSectionBlockCodeAndDaneCodeToFundamentalIndicators < ActiveRecord::Migration[7.1]
  def change
    add_reference :fundamental_indicators, :urban_section, null: false, foreign_key: true
    add_column :fundamental_indicators, :block_code, :integer
    add_column :fundamental_indicators, :dane_code, :integer

    remove_column :fundamental_indicators, :muncipality_code, :integer
    remove_column :fundamental_indicators, :department_code, :integer
  end
end
