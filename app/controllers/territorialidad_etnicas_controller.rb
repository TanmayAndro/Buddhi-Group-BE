class TerritorialidadEtnicasController < ApplicationController
    def create_bulk_territorialidad_etnicas
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
  
            value = row[0]&.value
            category = row[1]&.value
  
            next if value.nil? || category.nil?
  
            TerritorialidadEtnica.create!(
                value: value,
                category: category
            )
          end
        end
  
        render json: { message: 'Territorialidad Etnica file processed successfully' }, status: :ok
      rescue StandardError => e
        render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
      end
    end
  end
  