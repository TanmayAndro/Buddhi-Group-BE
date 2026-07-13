require 'csv'

class NewMarcoDeGeorreferenciacionsController < ApplicationController
  # BATCH_SIZE = 10_000

  # def create_bulk_marco_de_georreferenciacions
  #   if params[:file].nil?
  #     render json: { error: 'No file uploaded' }, status: :bad_request
  #     return
  #   end

  #   begin
  #     csv_file = params[:file].tempfile
  #     marco_de_georreferenciacions = []
  #     row_count = 0

  #     ActiveRecord::Base.transaction do
  #       CSV.foreach(csv_file, headers: true, encoding: 'bom|utf-8', col_sep: "\t").with_index do |row, index|
  #         break if index >= 10

  #         encuesta_code = row['COD_ENCUESTAS']
  #         vivienda_code = row['U_VIVIENDA'].to_s.rjust(3, '0')
  #         common_key = "#{encuesta_code}#{vivienda_code}"

  #         marco_de_georreferenciacions << {
  #           department_code: row['U_DPTO'],
  #           muncipality_code: row['U_MPIO'],
  #           unit_info: row['UA_CLASE'],
  #           rural_sector: row['U_SECT_RUR'],
  #           rural_section: row['U_SECC_RUR'],
  #           populated_center: row['UA2_CPOB'],
  #           urban_sector: row['U_SECT_URB'],
  #           urban_section: row['U_SECC_URB'],
  #           block: row['U_MZA'],
  #           common_key: common_key,
  #           created_at: Time.current,
  #           updated_at: Time.current
  #         }

  #         row_count += 1

  #         if marco_de_georreferenciacions.size >= BATCH_SIZE
  #           NewMarcoDeGeorreferenciacion.insert_all(marco_de_georreferenciacions)
  #           marco_de_georreferenciacions.clear
  #         end
  #       end

  #       NewMarcoDeGeorreferenciacion.insert_all(marco_de_georreferenciacions) if marco_de_georreferenciacions.any?
  #     end

  #     render json: { message: "Successfully imported #{row_count} marco_de_georreferenciacions (test limit)" }, status: :ok
  #   rescue StandardError => e
  #     render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
  #   end
  # end


  def import_divipola
    file = params[:file]

    if file.nil?
      return render json: { error: "No file uploaded" }, status: :bad_request
    end

    spreadsheet = Roo::Spreadsheet.open(file.tempfile.path)
    sheet = spreadsheet.sheet(0)

    updated_count = 0
    unmatched = []

    sheet.each_row_streaming(offset: 3) do |row|
      dept_code = row[0]&.cell_value.to_s.strip
      dept_name = row[1]&.cell_value.to_s.strip
      mun_code  = row[2]&.cell_value.to_s.strip
      mun_name  = row[3]&.cell_value.to_s.strip

      next if dept_code.blank? || mun_code.blank?

      dept_code_int = dept_code.to_i
      mun_code_int  = mun_code.sub(/^#{dept_code}/, "").to_i

      records = UniqueGeorreferenciacion.where(
        department_code: dept_code_int,
        muncipality_code: mun_code_int
      )

      if records.exists?
        records.update_all(
          department: dept_name,
          municipality: mun_name,
          updated_at: Time.current
        )
        updated_count += records.size
      else
        unmatched << {
          department_code: dept_code_int,
          municipality_code: mun_code_int,
          department_name: dept_name,
          municipality_name: mun_name
        }
      end
    end

    render json: {
      message: "DIVIPOLA import completed",
      updated_records: updated_count,
      unmatched: unmatched
    }
  end
end
