class CreatePopulatedCenters < ActiveRecord::Migration[7.1]
  def change
    create_table :populated_centers do |t|
      t.string :name
      t.references :rural_section, null: false, foreign_key: true

      t.timestamps
    end
  end
end
