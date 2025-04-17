class CreateMarcoDeGeorreferenciacions < ActiveRecord::Migration[7.1]
  def change
    create_table :marco_de_georreferenciacions do |t|

      t.integer :department_code
      t.integer :muncipality_code
      t.integer :unit_info
      t.timestamps
    end
  end
end
