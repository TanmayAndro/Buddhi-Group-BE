class AddColumnInNewFallecido < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      ALTER TABLE new_fallecidos
      ADD COLUMN rural_sector VARCHAR,
      ADD COLUMN rural_section VARCHAR,
      ADD COLUMN populated_center VARCHAR,
      ADD COLUMN urban_sector VARCHAR,
      ADD COLUMN urban_section VARCHAR,
      ADD COLUMN block VARCHAR,
      ADD COLUMN dane_code_anm VARCHAR
    SQL
  end

  def down
    change_table :new_fallecidos do |t|
      t.remove :rural_sector, :rural_section, :populated_center,
               :urban_sector, :urban_section, :block, :dane_code_anm
    end
  end
end
