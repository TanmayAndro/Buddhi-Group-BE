class MunicipiosController < ApplicationController
    def create_bulk_municipios
      if params[:file].nil?
        render json: { error: 'No file uploaded' }, status: :bad_request
        return
      end
  
      begin
        xls_file = params[:file].tempfile
        spreadsheet = Roo::Spreadsheet.open(xls_file)
        sheet = spreadsheet.sheet(0)
  
        ActiveRecord::Base.transaction do
          sheet.each_row_streaming(offset: 1) do |row|
            next if row.compact.empty?
  
            department_code = row[0]&.value
            muncipality_code = row[1]&.value
            muncipality = row[2]&.value&.gsub(/\r?\n/, ' ')
            department = row[3]&.value
  
            next if department_code.nil? || muncipality_code.nil? || muncipality.nil? || department.nil?
  
            Municipio.create!(
              department_code: department_code,
              muncipality_code: muncipality_code,
              muncipality: muncipality,
              department: department
            )
          end
        end
  
        render json: { message: 'Municipio file processed successfully' }, status: :ok
      rescue StandardError => e
        render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
      end
    end
  end
  