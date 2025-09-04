class AddColumnToPrimaryIndicator < ActiveRecord::Migration[7.1]
  def change
    add_column :primary_indicators, :block_code, :string
    add_column :primary_indicators, :dane_code, :string
    add_index :primary_indicators, :dane_code, unique: true

  end
end
