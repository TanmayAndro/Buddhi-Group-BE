class AddNewAgeGroupToNewPersonaTable < ActiveRecord::Migration[7.1]
  def change
    add_column :new_personas, :new_age_group, :string
  end
end
