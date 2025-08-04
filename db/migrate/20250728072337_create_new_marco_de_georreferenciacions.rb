class CreateNewMarcoDeGeorreferenciacions < ActiveRecord::Migration[7.1]
  def change
    create_table :new_marco_de_georreferenciacions do |t|
      t.integer :department_code
      t.integer :muncipality_code
      t.integer :unit_info
      t.string  :rural_sector
      t.string :rural_section
      t.string :populated_center
      t.string :urban_sector
      t.string :urban_section
      t.string :block
      t.integer :survey_code
      t.integer :housing_unit
      t.string :common_key
      t.bigint :dane_code_anm
      t.timestamps
    end
  end
end
