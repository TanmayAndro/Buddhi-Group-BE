class CreateUaClasses < ActiveRecord::Migration[7.1]
  def change
    create_table :ua_classes do |t|
      t.string :name
      t.references :municipality, null: false, foreign_key: true

      t.timestamps
    end
  end
end
