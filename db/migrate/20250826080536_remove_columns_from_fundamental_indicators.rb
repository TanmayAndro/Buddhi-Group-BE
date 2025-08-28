class RemoveColumnsFromFundamentalIndicators < ActiveRecord::Migration[7.1]
  def change
    remove_column :fundamental_indicators, :under_fifteen, :integer
    remove_column :fundamental_indicators, :fifteen_to_twenty_nine, :integer
    remove_column :fundamental_indicators, :women_with_child_wearing_age, :integer
    remove_column :fundamental_indicators, :sex_ratio, :float
    remove_column :fundamental_indicators, :fifteen_to_sixty_four, :integer
    remove_column :fundamental_indicators, :total_occupied_dwellings, :integer
  end
end
