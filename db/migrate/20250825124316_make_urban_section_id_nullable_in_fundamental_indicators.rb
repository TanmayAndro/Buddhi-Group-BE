class MakeUrbanSectionIdNullableInFundamentalIndicators < ActiveRecord::Migration[7.1]
  def change
     change_column_null :fundamental_indicators, :urban_section_id, true
  end
end
