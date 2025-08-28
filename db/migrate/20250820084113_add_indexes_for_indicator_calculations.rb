class AddIndexesForIndicatorCalculations < ActiveRecord::Migration[7.1]
      disable_ddl_transaction! 
 
  def change
    # 📌 NewPersona indexes
    add_index :new_personas, :block, algorithm: :concurrently
    add_index :new_personas, [:block, :gender], algorithm: :concurrently
    add_index :new_personas, [:block, :age_group], algorithm: :concurrently
    add_index :new_personas, [:block, :activity_status], algorithm: :concurrently
    add_index :new_personas, [:block, :school_presence], algorithm: :concurrently
    add_index :new_personas, [:block, :literacy_rate], algorithm: :concurrently
    add_index :new_personas, [:block, :child_birth], algorithm: :concurrently
    add_index :new_personas, [:block, :ethnicicity_status], algorithm: :concurrently

    # 📌 NewVivienda indexes
    add_index :new_viviendas, :block, algorithm: :concurrently
    add_index :new_viviendas, [:block, :internet_availability], algorithm: :concurrently
    add_index :new_viviendas, [:block, :sanitory_quality], algorithm: :concurrently
    add_index :new_viviendas, [:block, :electricity_availability], algorithm: :concurrently

    # 📌 NewHogare indexes
    add_index :new_hogares, :block, algorithm: :concurrently
  end
end
