class CreateEdadFall < ActiveRecord::Migration[7.1]
  def change
    create_table :edad_falls do |t|

      t.integer :value
      t.string :category
      t.timestamps
    end
  end
end
