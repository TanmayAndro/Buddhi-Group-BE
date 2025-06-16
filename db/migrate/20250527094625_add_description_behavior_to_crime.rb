class AddDescriptionBehaviorToCrime < ActiveRecord::Migration[7.1]
  def change
    add_column :crimes, :description_behaviour, :string #DESCRIPCION CONDUCTA
  end
end
