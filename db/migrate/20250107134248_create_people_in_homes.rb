class CreatePeopleInHomes < ActiveRecord::Migration[7.1]
  def change
    create_table :people_in_homes do |t|

      t.integer :value
      t.string :category
      t.timestamps
    end
  end
end
