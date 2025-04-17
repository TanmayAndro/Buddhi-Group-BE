class AddProtectedAreaCodeToViviendas < ActiveRecord::Migration[7.1]
  def change
    add_column :viviendas, :protected_area_code, :integer
  end
end
