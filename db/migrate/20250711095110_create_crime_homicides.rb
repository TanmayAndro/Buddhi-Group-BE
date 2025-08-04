class CreateCrimeHomicides < ActiveRecord::Migration[7.1]
  def change
    create_table :crime_homicides do |t|
      t.integer :department_code
      t.integer :municipality_code
      t.integer :twenty_ten, default: 0
      t.integer :twenty_eleven, default: 0
      t.integer :twenty_twelve, default: 0
      t.integer :twenty_thirteen, default: 0
      t.integer :twenty_fourteen, default: 0
      t.integer :twenty_fifteen, default: 0
      t.integer :twenty_sixteen, default: 0
      t.integer :twenty_seventeen, default: 0
      t.integer :twenty_eighteen, default: 0
      t.integer :twenty_nineteen, default: 0
      t.integer :twenty_twenty, default: 0
      t.integer :twenty_twenty_one, default: 0
      t.integer :twenty_twenty_two, default: 0
      t.integer :twenty_twenty_three, default: 0
      t.integer :twenty_twenty_four, default: 0

      t.timestamps
    end
  end
end
