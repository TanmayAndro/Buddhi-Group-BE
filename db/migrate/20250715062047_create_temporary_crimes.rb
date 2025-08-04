class CreateTemporaryCrimes < ActiveRecord::Migration[7.1]
  def change
    create_table :temporary_crimes do |t|

      t.string :crime_type                  # DELITO
      t.string :department             # DEPARTAMENTO
      t.string :municipality           # MUNICIPIO
      t.string :dane_code              # CODIGO DANE
      t.string :weapons_types          # ARMAS MEDIOS
      t.date   :incident_date          # FECHA HECHO
      t.string :gender                 # GENERO
      t.string :age_group              # AGRUPA EDAD PERSONA
      t.integer :quantity              # CANTIDAD

      t.timestamps

    end
  end
end
