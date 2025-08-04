require 'csv'

class HogaresController < ApplicationController
  BATCH_SIZE = 10_000

  def create_bulk_hogares
    if params[:file].nil?
      render json: { error: 'No file uploaded' }, status: :bad_request
      return
    end

    begin
      csv_file = params[:file].tempfile
      hogares = []
      row_count = 0

      ActiveRecord::Base.transaction do
        CSV.foreach(csv_file, headers: true, encoding: 'bom|utf-8') do |row|
          type_of_record = row['TIPO_REG']
          department_code = row['U_DPTO']
          muncipality_code = row['U_MPIO']
          unit_info = row['UA_CLASE']
          household_number = row['H_NROHOG']
          rooms_count = row['H_NRO_CUARTOS']
          bedroom_count = row['H_NRO_DORMIT']
          kitchen_area = row['H_DONDE_PREPALIM']
          water_source = row['H_AGUA_COCIN']
          death_2017 = row['HA_NRO_FALL']
          people_count = row['HA_TOT_PER'] 
          encuesta_code = row['COD_ENCUESTAS']
          vivienda_code = row['U_VIVIENDA'].to_s.rjust(3, '0')
          common_key = "#{encuesta_code}#{vivienda_code}"

          hogares << {
            type_of_record: type_of_record,
            department_code: department_code,
            muncipality_code: muncipality_code,
            unit_info: unit_info,
            household_number: household_number,
            rooms_count: rooms_count,
            bedroom_count: bedroom_count,
            kitchen_area: kitchen_area,
            water_source: water_source,
            death_2017: death_2017,
            people_count: people_count,
            created_at: Time.current,
            updated_at: Time.current,
            survey_code: encuesta_code,
            housing_unit: vivienda_code,
            common_key: common_key
          }

          row_count += 1

          if hogares.size >= BATCH_SIZE
            NewHogare.insert_all(hogares)
            hogares.clear
          end
        end

        # Insert remaining rows
        NewHogare.insert_all(hogares) if hogares.any?
      end

      render json: { message: "Successfully imported #{row_count} hogares" }, status: :ok
    rescue StandardError => e
      render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
    end
  end
end
