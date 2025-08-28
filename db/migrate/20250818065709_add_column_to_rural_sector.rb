class AddColumnToRuralSector < ActiveRecord::Migration[7.1]
  def change
    add_column :rural_sectors, :rural_sector_code, :integer
  end
end
