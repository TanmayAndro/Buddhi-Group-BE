class CreateDaneCodeTestings < ActiveRecord::Migration[7.1]
  def change
    create_table :dane_code_testings do |t|
      t.string "dane_code_anm"

      t.timestamps
    end
  end
end
