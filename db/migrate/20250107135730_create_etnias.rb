class CreateEtnias < ActiveRecord::Migration[7.1]
  def change
    create_table :etnias do |t|

      t.integer :value
      t.string :category
      
      t.timestamps
    end
  end
end
