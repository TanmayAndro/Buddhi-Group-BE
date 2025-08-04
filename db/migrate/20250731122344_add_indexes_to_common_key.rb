class AddIndexesToCommonKey < ActiveRecord::Migration[7.1]
    def change
    # Add indexes only if the column exists and is not already indexed
    add_index :new_fallecidos, :common_key unless index_exists?(:new_fallecidos, :common_key)
    add_index :new_hogares, :common_key unless index_exists?(:new_hogares, :common_key)
    add_index :new_marco_de_georreferenciacions, :common_key unless index_exists?(:new_marco_de_georreferenciacions, :common_key)
    add_index :new_personas, :common_key unless index_exists?(:new_personas, :common_key)
    add_index :new_viviendas, :common_key unless index_exists?(:new_viviendas, :common_key)
  end
end
