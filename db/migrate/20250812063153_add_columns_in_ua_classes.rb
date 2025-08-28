class AddColumnsInUaClasses < ActiveRecord::Migration[7.1]
  def change
    remove_column :ua_classes, :name, :string
    remove_column :rural_sections, :name, :string
    remove_column :rural_sectors, :name, :string
    remove_column :urban_sections, :name, :string
    remove_column :municipalities, :name, :string
    add_column  :ua_classes, :unit_info, :integer 
  end
end
