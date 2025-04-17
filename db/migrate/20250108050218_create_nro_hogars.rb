class CreateNroHogars < ActiveRecord::Migration[7.1]
  def change
    create_table :nro_hogars do |t|

      t.integer :value
      t.string :category
      
      t.timestamps
    end
  end
end
