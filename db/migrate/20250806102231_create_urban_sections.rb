class CreateUrbanSections < ActiveRecord::Migration[7.1]
  def change
    create_table :urban_sections do |t|
      t.string :name
      t.references :urban_sector, null: false, foreign_key: true

      t.timestamps
    end
  end
end
