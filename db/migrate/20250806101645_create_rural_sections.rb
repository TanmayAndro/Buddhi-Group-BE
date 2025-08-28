class CreateRuralSections < ActiveRecord::Migration[7.1]
  def change
    create_table :rural_sections do |t|
      t.string :name
      t.references :rural_sector, null: false, foreign_key: true

      t.timestamps
    end
  end
end
