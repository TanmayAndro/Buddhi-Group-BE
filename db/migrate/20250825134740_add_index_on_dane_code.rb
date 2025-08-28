class AddIndexOnDaneCode < ActiveRecord::Migration[7.1]
      disable_ddl_transaction!  # allows concurrent index creation

  def change
    add_index :fundamental_indicators, :dane_code, unique: true, algorithm: :concurrently
  end
end
