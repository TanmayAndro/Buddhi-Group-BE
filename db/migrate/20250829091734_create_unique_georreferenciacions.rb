class CreateUniqueGeorreferenciacions < ActiveRecord::Migration[7.1]
  def change
    create_table :unique_georreferenciacions do |t|
      t.integer :department_code
      t.integer :muncipality_code
      t.integer :unit_info
      t.string  :rural_sector
      t.string  :rural_section
      t.string  :populated_center
      t.string  :urban_sector
      t.string  :urban_section
      t.string  :block
      t.string  :dane_code_anm

      t.timestamps
    end

    add_index :unique_georreferenciacions, :dane_code_anm, unique: true
  end
end

