class CreateVivoAnos < ActiveRecord::Migration[7.1]
  def change
    create_table :vivo_anos do |t|

      t.integer :value
      t.string :category
      
      t.timestamps
    end
  end
end
