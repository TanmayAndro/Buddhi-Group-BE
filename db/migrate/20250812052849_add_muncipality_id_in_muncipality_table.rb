class AddMuncipalityIdInMuncipalityTable < ActiveRecord::Migration[7.1]
  def change
    add_column :departments, :department_id, :integer
    remove_column :departments, :name, :string
    add_column :municipalities, :municipality_id, :integer
    add_column :municipalities, :department_code, :integer
  end
end
