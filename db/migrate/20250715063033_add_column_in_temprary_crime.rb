class AddColumnInTempraryCrime < ActiveRecord::Migration[7.1]
  def change
    add_column :temporary_crimes, :department_code, :integer
    add_column :temporary_crimes, :municipality_code, :integer
  end
end
