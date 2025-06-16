class AddDepartmentCodeToCrime < ActiveRecord::Migration[7.1]
  def change
    add_column :crimes, :department_code, :integer
  end
end
