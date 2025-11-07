class AddPollingIdToElectoralRollstable < ActiveRecord::Migration[7.1]
  def change
    add_column :electoral_rolls, :new_polling_id, :string
    add_column :votes, :new_polling_id, :string
  end
end
