class AddYearAndMonthToCrime < ActiveRecord::Migration[7.1]
  def change
    add_column :crimes, :year, :string
    add_column :crimes, :month, :string
  end
end
