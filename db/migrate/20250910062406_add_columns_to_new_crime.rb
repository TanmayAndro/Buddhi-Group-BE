class AddColumnsToNewCrime < ActiveRecord::Migration[7.1]
  def change
    add_column :new_crimes, :gender_code, :integer
    add_column :new_crimes, :age_group_code, :integer
  end
end
