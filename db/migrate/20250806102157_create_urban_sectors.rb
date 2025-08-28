class CreateUrbanSectors < ActiveRecord::Migration[7.1]
  def change
    create_table :urban_sectors do |t|
      t.string :name
      t.references :populated_center, null: false, foreign_key: true

      t.timestamps
    end
  end
end
