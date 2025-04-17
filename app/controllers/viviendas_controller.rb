require 'csv'

class ViviendasController < ApplicationController
  BATCH_SIZE = 10_000

  def create_bulk_viviendas
    if params[:file].nil?
      render json: { error: 'No file uploaded' }, status: :bad_request
      return
    end

    begin
      csv_file = params[:file].tempfile
      viviendas = []
      row_count = 0

      ActiveRecord::Base.transaction do
        CSV.foreach(csv_file, headers: true, encoding: 'bom|utf-8') do |row|
          department_code = row['U_DPTO']
          muncipality_code = row['U_MPIO']
          unit_info = row['UA_CLASE']
          ethnic_territory = row['UVA_ESTATER'] #boolean
          ethnic_territory_type = row['UVA1_TIPOTER']
          ethnic_territory_code = row['UVA2_CODTER']
          is_protected_area = row['UVA_ESTA_AREAPROT']
          protected_area_code = row['UVA1_COD_AREAPROT']
          home_usage = row['UVA_USO_UNIDAD']
          house_type = row['V_TIPO_VIV']
          houses_occupation = row['V_CON_OCUP']
          number_of_homes = row['V_TOT_HOG']
          contruction_material = row['V_MAT_PARED']
          electricity_availability = row['VA_EE'] #boolean
          socioeconomic_status = row['VA1_ESTRATO']
          aquaduct_availability = row['VB_ACU'] #boolean
          sewe_availability = row['VC_ALC'] #boolean
          gas_availability = row['VD_GAS']
          garbage_disposability = row['VE_RECBAS']
          disposal_frequency = row['VE1_QSEM']
          internet_availability = row['VF_INTERNET'] #boolean
          sanitory_quality = row['V_TIPO_SERSA']
          house_category = row['L_TIPO_INST']
          home_availability = row['L_EXISTEHOG']
          resident_number = row['L_TOT_PERL']


          viviendas << {
            department_code: department_code,
            muncipality_code: muncipality_code,
            unit_info: unit_info,
            ethnic_territory: to_boolean(ethnic_territory),
            ethnic_territory_type: ethnic_territory_type,
            ethnic_territory_code: ethnic_territory_code,
            is_protected_area: is_protected_area,
            protected_area_code: protected_area_code,
            home_usage: home_usage,
            house_type: house_type,
            houses_occupation: houses_occupation,
            number_of_homes: number_of_homes,
            contruction_material: contruction_material,
            electricity_availability: to_boolean(electricity_availability),
            socioeconomic_status: socioeconomic_status,
            aquaduct_availability: to_boolean(aquaduct_availability),
            sewe_availability: to_boolean(sewe_availability),
            gas_availability: gas_availability,
            garbage_disposability: garbage_disposability,
            disposal_frequency: disposal_frequency,
            internet_availability: to_boolean(internet_availability),
            sanitory_quality: sanitory_quality,
            house_category: house_category,
            home_availability: home_availability,
            resident_number: resident_number,
            created_at: Time.current,
            updated_at: Time.current
          }

          row_count += 1

          if viviendas.size >= BATCH_SIZE
            Vivienda.insert_all(viviendas)
            viviendas.clear
          end
        end

        # Insert remaining rows
        Vivienda.insert_all(viviendas) if viviendas.any?
      end

      render json: { message: "Successfully imported #{row_count} viviendas" }, status: :ok
    rescue StandardError => e
      render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
    end
  end
end
