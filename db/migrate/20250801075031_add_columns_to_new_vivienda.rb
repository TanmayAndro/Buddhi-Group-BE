class AddColumnsToNewVivienda < ActiveRecord::Migration[7.1]
  def change
    add_column :new_viviendas, :rural_sector, :string 
    add_column :new_viviendas, :rural_section, :string
    add_column :new_viviendas, :populated_center, :string
    add_column :new_viviendas, :urban_sector, :string
    add_column :new_viviendas, :urban_section, :string
    add_column :new_viviendas, :block, :string
    add_column :new_viviendas, :dane_code_anm, :string
  end
end
