class AddCodeToUrbanSector < ActiveRecord::Migration[7.1]
  def change
    add_column :urban_sectors, :urban_sector_code, :integer
    remove_column :urban_sectors, :name, :string
  end
end
