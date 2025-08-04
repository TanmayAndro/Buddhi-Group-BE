require 'csv'

class FallecidosController < ApplicationController
  BATCH_SIZE = 10_000

  def create_bulk_fallecidos
    if params[:file].nil?
      render json: { error: 'No file uploaded' }, status: :bad_request
      return
    end

    begin
      csv_file = params[:file].tempfile
      fallecidos = []
      row_count = 0

      ActiveRecord::Base.transaction do
        CSV.foreach(csv_file, headers: true, encoding: 'bom|utf-8') do |row|
          type_of_record = row['TIPO_REG']
          department_code = row['U_DPTO']
          muncipality_code = row['U_MPIO']
          unit_info = row['UA_CLASE']
          household_number = row['F_NROHOG']
          death_count = row['FA1_NRO_FALL']
          gender_indicator = row['FA2_SEXO_FALL']
          death_age = row['FA3_EDAD_FALL']
          certificate_availability = row['FA4_CERT_DEFUN']
          encuesta_code = row['COD_ENCUESTAS']
          vivienda_code = row['U_VIVIENDA'].to_s.rjust(3, '0')
          common_key = "#{encuesta_code}#{vivienda_code}"

          fallecidos << {
            type_of_record: type_of_record,
            department_code: department_code,
            muncipality_code: muncipality_code,
            unit_info: unit_info,
            household_number: household_number,
            death_count: death_count,
            gender_indicator: gender_indicator,
            death_age: death_age,
            certificate_availability: certificate_availability,
            created_at: Time.current,
            updated_at: Time.current,
            survey_code: encuesta_code,
            housing_unit: vivienda_code,
            common_key: common_key
          }

          row_count += 1

          if fallecidos.size >= BATCH_SIZE
            NewFallecido.insert_all(fallecidos)
            fallecidos.clear
          end
        end

        # Insert remaining rows
        NewFallecido.insert_all(fallecidos) if fallecidos.any?
      end

      render json: { message: "Successfully imported #{row_count} fallecidos" }, status: :ok
    rescue StandardError => e
      render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
    end
  end
end
