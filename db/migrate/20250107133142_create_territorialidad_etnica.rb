class CreateTerritorialidadEtnica < ActiveRecord::Migration[7.1]
  def change
    create_table :territorialidad_etnicas do |t|

      t.integer :value
      t.text :category
      
      t.timestamps
    end
  end
end
