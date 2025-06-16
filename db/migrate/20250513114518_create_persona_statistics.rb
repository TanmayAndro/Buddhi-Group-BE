class CreatePersonaStatistics < ActiveRecord::Migration[7.1]
  def change
    create_table :fundamental_indicators do |t|
      t.integer :muncipality_code
      t.integer :department_code
      t.integer :total_dwellings
      t.integer :total_occupied_dwellings
      t.integer :total_house_holds
      t.integer :total_population
      t.integer :male_count
      t.integer :female_count
      t.integer :children_under_five
      t.integer :under_fifteen
      t.integer :over_fifteen
      t.integer :fifteen_to_twenty_nine
      t.integer :fifteen_to_sixty_four
      t.integer :over_sixty_four
      t.integer :women_with_child_wearing_age
      t.float   :sex_ratio
      t.timestamps
    end
  end
end
