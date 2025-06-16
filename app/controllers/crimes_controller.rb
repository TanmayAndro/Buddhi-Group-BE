class CrimesController < ApplicationController
    # def create_bulk_crimes
    #   if params[:file].nil?
    #     render json: { error: 'No file uploaded' }, status: :bad_request
    #     return
    #   end
    
    #   begin
    #     xls_file = params[:file].tempfile
    #     spreadsheet = Roo::Spreadsheet.open(xls_file)
    #     sheet = spreadsheet.sheet(0)
    
    #     ActiveRecord::Base.transaction do
    #       sheet.each_row_streaming(offset: 1) do |row|
    #         next if row.compact.empty?
    
    #         crime_type    = row[0]&.value   # DELITO
    #         department    = row[1]&.value   # DEPARTAMENTO
    #         municipality  = row[2]&.value   # MUNICIPIO
    #         dane_code     = row[3]&.value   # CODIGO DANE
    #         weapons_types = row[4]&.value   # ARMAS MEDIOS
    
    #         # Safe date parsing
    #         raw_date = row[5]&.value
    #         incident_date = raw_date.is_a?(Date) ? raw_date : Date.parse(raw_date.to_s) rescue nil
    
    #         gender     = row[6]&.value       # GENERO
    #         age_group  = row[7]&.value       # *AGRUPA EDAD PERSONA
    #         quantity   = row[8]&.value # CANTIDAD
    
    #         # Required field check
    #         next if crime_type.nil? || department.nil? || municipality.nil?
    
    #         Crime.create!(
    #           crime_type: crime_type,
    #           department: department,
    #           municipality: municipality,
    #           dane_code: dane_code.to_s,
    #           weapons_types: weapons_types,
    #           incident_date: incident_date,
    #           gender: nil,
    #           age_group: age_group,
    #           quantity: quantity,
    #           art_crime: nil
    #         )
    #       end
    #     end
    
    #     render json: { message: 'Crimes file processed successfully' }, status: :ok
    #   rescue StandardError => e
    #     render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
    #   end
    # end

    
    def create_bulk_crimes
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
    
            crime_type   = row[0]&.value # DELITO
            department   = row[1]&.value # Departamento
            municipality = row[2]&.value # Municipio
            dane_code    = row[3]&.value # CODIGO DANE
            weapons_type = row[4]&.value # ARMAS MEDIOS
    
            raw_date = row[5]&.value     # FECHA HECHO
            incident_date = raw_date.is_a?(Date) ? raw_date : Date.parse(raw_date.to_s) rescue nil
    
            quantity = row[6]&.value     # CANTIDAD
    
            # Skip rows with missing required fields
            next if crime_type.nil? || department.nil? || municipality.nil? || incident_date.nil?
    
            Crime.create!(
              crime_type: crime_type,
              department: department,
              municipality: municipality,
              dane_code: dane_code.to_s,
              weapons_types: weapons_type,
              incident_date: incident_date,
              quantity: quantity
            )
          end
        end
    
        render json: { message: 'Crimes file processed successfully' }, status: :ok
      rescue StandardError => e
        render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
      end
    end
    
  end
  