class CreateAreasProtegidas < ActiveRecord::Migration[7.1]
  def change
    create_table :areas_protegidas do |t|

      t.integer :value
      t.text :category
      t.timestamps
    end
  end
end
