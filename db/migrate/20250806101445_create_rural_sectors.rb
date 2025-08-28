class CreateRuralSectors < ActiveRecord::Migration[7.1]
  def change
    create_table :rural_sectors do |t|
      t.string :name
      t.references :ua_class, null: false, foreign_key: true

      t.timestamps
    end
  end
end
