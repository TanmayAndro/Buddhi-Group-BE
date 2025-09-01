class RemoveUrbanSectionFromFundamentalIndicators < ActiveRecord::Migration[7.1]
  def change
    remove_reference :fundamental_indicators, :urban_section, foreign_key: true, index: true
  end
end
