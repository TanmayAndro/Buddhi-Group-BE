class AddNovPollingIdToElectoralRolls < ActiveRecord::Migration[7.1]
  def change
    add_column :electoral_rolls, :nov_polling_id, :string
  end
end
