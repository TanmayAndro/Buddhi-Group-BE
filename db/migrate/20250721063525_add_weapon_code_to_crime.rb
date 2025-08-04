class AddWeaponCodeToCrime < ActiveRecord::Migration[7.1]
  def change
    add_column :crimes, :weapon_code, :integer
  end
end
