class AddPollingIdToPollingStation < ActiveRecord::Migration[7.1]
  def change
    add_column :polling_stations, :polling_id, :string
  end
end
