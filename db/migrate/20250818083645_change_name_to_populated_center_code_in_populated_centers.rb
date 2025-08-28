class ChangeNameToPopulatedCenterCodeInPopulatedCenters < ActiveRecord::Migration[7.1]
  def change
    remove_column :populated_centers, :name, :string
    add_column :populated_centers, :populated_center_code, :integer
  end
end
