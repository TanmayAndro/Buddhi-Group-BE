class ChangeBlockCodeToStringInFundamentalIndicators < ActiveRecord::Migration[7.1]
  def change
    change_column :fundamental_indicators, :block_code, :string, using: 'block_code::text'
  end
end
