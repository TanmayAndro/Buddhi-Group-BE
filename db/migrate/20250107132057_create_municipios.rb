class CreateMunicipios < ActiveRecord::Migration[7.1]
  def change
    create_table :municipios do |t|

      t.integer :department_code
      t.integer :muncipality_code
      t.text :muncipality
      t.text :department
      
      t.timestamps
    end
  end
end
