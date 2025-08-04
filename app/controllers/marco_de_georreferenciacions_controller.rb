require 'csv'

class MarcoDeGeorreferenciacionsController < ApplicationController
  BATCH_SIZE = 10_000

  def create_bulk_marco_de_georreferenciacions
    if params[:file].nil?
      render json: { error: 'No file uploaded' }, status: :bad_request
      return
    end

    begin
      csv_file = params[:file].tempfile
      marco_de_georreferenciacions = []
      row_count = 0

      ActiveRecord::Base.transaction do
        CSV.foreach(csv_file, headers: true, encoding: 'bom|utf-8') do |row|
          department_code    = row['U_DPTO']
          muncipality_code   = row['U_MPIO']
          unit_info          = row['UA_CLASE']
          rural_sector       = row['U_SECT_RUR']
          rural_section      = row['U_SECC_RUR']
          populated_center   = row['UA2_CPOB']
          urban_sector       = row['U_SECT_URB']
          urban_section      = row['U_SECC_URB']
          block              = row['U_MZA']
          encuesta_code      = row['COD_ENCUESTAS']  # add this into database as well 
          vivienda_code      = row['U_VIVIENDA'].to_s.rjust(3, '0') # add this into database as well

          # Derived column
          common_key = "#{encuesta_code}#{vivienda_code}".to_i

          # Build row
          marco_de_georreferenciacions << {
            department_code: department_code,
            muncipality_code: muncipality_code,
            unit_info: unit_info,
            rural_sector: rural_sector,
            rural_section: rural_section,
            populated_center: populated_center,
            urban_sector: urban_sector,
            urban_section: urban_section,
            block: block,
            survey_code: encuesta_code,
            housing_unit: vivienda_code,
            common_key: common_key,
            created_at: Time.current,
            updated_at: Time.current
          }

          row_count += 1

          if marco_de_georreferenciacions.size >= BATCH_SIZE
            NewMarcoDeGeorreferenciacion.insert_all(marco_de_georreferenciacions)
            marco_de_georreferenciacions.clear
          end
        end

        NewMarcoDeGeorreferenciacion.insert_all(marco_de_georreferenciacions) if marco_de_georreferenciacions.any?
      end

      render json: { message: "Successfully imported #{row_count} marco_de_georreferenciacions" }, status: :ok
    rescue StandardError => e
      render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
    end
  end
end
