class AddTypeOfRecordToMultipleTables < ActiveRecord::Migration[7.1]
  def change
    add_column :fallecidos, :type_of_record, :integer
    add_column :hogares, :type_of_record, :integer
    add_column :personas, :type_of_record, :integer
    add_column :viviendas, :type_of_record, :integer
  end
end
