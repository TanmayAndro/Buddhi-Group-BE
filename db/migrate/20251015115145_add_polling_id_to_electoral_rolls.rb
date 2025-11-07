class AddPollingIdToElectoralRolls < ActiveRecord::Migration[7.1]
  def change
    add_column :electoral_rolls, :polling_id, :string
    add_index :electoral_rolls, :polling_id
  end
end
