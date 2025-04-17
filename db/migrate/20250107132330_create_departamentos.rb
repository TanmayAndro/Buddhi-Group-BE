class CreateDepartamentos < ActiveRecord::Migration[7.1]
  def change
    create_table :departamentos do |t|

      t.integer :value
      t.text :category
      
      t.timestamps
    end
  end
end
