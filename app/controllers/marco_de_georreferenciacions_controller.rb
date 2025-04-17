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
          department_code = row['U_DPTO']
          muncipality_code = row['U_MPIO']
          unit_info = row['UA_CLASE']

          marco_de_georreferenciacions << {
            department_code: department_code,
            muncipality_code: muncipality_code,
            unit_info: unit_info,
            created_at: Time.current,
            updated_at: Time.current
          }

          row_count += 1

          if marco_de_georreferenciacions.size >= BATCH_SIZE
            MarcoDeGeorreferenciacion.insert_all(marco_de_georreferenciacions)
            marco_de_georreferenciacions.clear
          end
        end

        # Insert remaining rows
        MarcoDeGeorreferenciacion.insert_all(marco_de_georreferenciacions) if marco_de_georreferenciacions.any?
      end

      render json: { message: "Successfully imported #{row_count} marco_de_georreferenciacions" }, status: :ok
    rescue StandardError => e
      render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
    end
  end
end
