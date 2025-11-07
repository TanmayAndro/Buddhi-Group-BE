class AddColumnToPollingStation < ActiveRecord::Migration[7.1]
  def change
    add_column :polling_stations, :department_code, :string
    add_column :polling_stations, :municipality_code, :string
    add_column :polling_stations, :polling_station_code, :string
  end
end
