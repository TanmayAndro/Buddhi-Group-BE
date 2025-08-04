class AddColumnsToPersonaAndHogare < ActiveRecord::Migration[7.1]
  def change
    add_column :new_personas, :rural_sector, :string 
    add_column :new_personas, :rural_section, :string
    add_column :new_personas, :populated_center, :string
    add_column :new_personas, :urban_sector, :string
    add_column :new_personas, :urban_section, :string
    add_column :new_personas, :block, :string
    add_column :new_personas, :dane_code_anm, :string

    add_column :new_hogares, :rural_sector, :string 
    add_column :new_hogares, :rural_section, :string
    add_column :new_hogares, :populated_center, :string
    add_column :new_hogares, :urban_sector, :string
    add_column :new_hogares, :urban_section, :string
    add_column :new_hogares, :block, :string
    add_column :new_hogares, :dane_code_anm, :string
  end

end
