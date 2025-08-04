class ChangeDaneCodeAnmToString < ActiveRecord::Migration[7.1]
  def change
    change_column :new_marco_de_georreferenciacions, :dane_code_anm, :string
  end
end
