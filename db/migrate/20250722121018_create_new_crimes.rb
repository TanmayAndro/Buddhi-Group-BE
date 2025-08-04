class CreateNewCrimes < ActiveRecord::Migration[7.1]
  def change
    create_table :new_crimes do |t|
      t.string :crime_type
      t.string :department
      t.string :municipality
      t.string :dane_code
      t.string :weapons_types
      t.date   :incident_date
      t.string :gender
      t.string :age_group
      t.integer  :quantity
      t.string :art_crime
      t.string :description_behaviour
      t.integer :municipality_code
      t.integer :department_code
      t.integer :year
      t.integer :month
      t.integer :weapon_code

      t.timestamps
    end
  end
end
