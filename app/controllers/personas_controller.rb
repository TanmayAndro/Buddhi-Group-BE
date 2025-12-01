require 'csv'

class PersonasController < ApplicationController
  BATCH_SIZE = 10_000

  def create_bulk_personas
    if params[:file].nil?
      render json: { error: 'No file uploaded' }, status: :bad_request
      return
    end

    begin
      csv_file = params[:file].tempfile
      personas = []
      row_count = 0

      ActiveRecord::Base.transaction do
        CSV.foreach(csv_file, headers: true, encoding: 'bom|utf-8') do |row|
          type_of_record = row['TIPO_REG']
          department_code = row['U_DPTO']
          muncipality_code = row['U_MPIO']
          unit_info = row['UA_CLASE']
          household_number = row['P_NROHOG']
          number_of_person_in_household = row['P_NRO_PER']
          gender = row['P_SEXO']
          age_group = row['P_EDADR']
          relationship_status = row['P_PARENTESCOR']
          ethnicicity_status = row['PA1_GRP_ETNIC']
          indigenous_status = row['PA11_COD_ETNIA']
          clan_status = row['PA12_CLAN']
          vitsa_status = row['PA21_COD_VITSA']
          company_status = row['PA22_COD_KUMPA']
          language_status = row['PA_HABLA_LENG']
          language_understanding = row['PA1_ENTIENDE']
          another_language = row['PB_OTRAS_LENG']
          language_count = row['PB1_QOTRAS_LENG']
          birth_place = row['PA_LUG_NAC']
          residents_5_year = row['PA_VIVIA_5ANOS']
          residents_12_months = row['PA_VIVIA_1ANO']
          hospitalization_status = row['P_ENFERMO']
          treatment_status = row['P_QUEHIZO_PPAL']
          health_awareness = row['PA_LO_ATENDIERON']
          health_quality = row['PA1_CALIDAD_SERV']
          life_difficulty = row['CONDICION_FISICA']
          literacy_rate = row['P_ALFABETA']
          school_presence = row['PA_ASISTENCIA']
          highest_education = row['P_NIVEL_ANOSR']
          activity_status = row['P_TRABAJO']
          marital_status = row['P_EST_CIVIL']
          child_birth = row['PA_HNV']
          total_children = row['PA1_THNV']
          male_children = row['PA2_HNVH']
          female_children = row['PA3_HNVM']
          survival_count = row['PA_HNVS']
          children_survived = row['PA1_THSV']
          male_survived = row['PA2_HSVH']
          female_survived = row['PA3_HSVM']
          nonreciding_children = row['PA_HFC']
          nonreciding_count = row['PA1_THFC']
          nonreciding_male = row['PA2_HFCH']
          nonreciding_female = row['PA3_HFCM']
          birth_information = row['PA_UHNV']
          birth_month = row['PA1_MES_UHNV']
          birth_year = row['PA2_ANO_UHNV']
          encuesta_code = row['COD_ENCUESTAS']
          vivienda_code = row['U_VIVIENDA'].to_s.rjust(3, '0')
          common_key = "#{encuesta_code}#{vivienda_code}"

          personas << {
            type_of_record: type_of_record,
            department_code: department_code,
            muncipality_code: muncipality_code,
            unit_info: unit_info,
            household_number: household_number,
            number_of_person_in_household: number_of_person_in_household,
            gender: gender,
            age_group: age_group,
            relationship_status: relationship_status,
            ethnicicity_status: ethnicicity_status,
            indigenous_status: indigenous_status,
            clan_status: clan_status,
            vitsa_status: vitsa_status,
            company_status: company_status,
            language_status: language_status,
            language_understanding: language_understanding,
            another_language: another_language,
            language_count: language_count,
            birth_place: birth_place,
            residents_5_year: residents_5_year,
            residents_12_months: residents_12_months,
            hospitalization_status: hospitalization_status,
            treatment_status: treatment_status,
            health_awareness: health_awareness,
            health_quality: health_quality,
            life_difficulty: life_difficulty,
            literacy_rate: literacy_rate,
            school_presence: school_presence,
            highest_education: highest_education,
            activity_status: activity_status,
            marital_status: marital_status,
            child_birth: child_birth,
            total_children: total_children,
            male_children: male_children,
            female_children: female_children,
            survival_count: survival_count,
            children_survived: children_survived,
            male_survived: male_survived,
            female_survived: female_survived,
            nonreciding_children: nonreciding_children,
            nonreciding_count: nonreciding_count,
            nonreciding_male: nonreciding_male,
            nonreciding_female: nonreciding_female,
            birth_information: birth_information,
            birth_month: birth_month,
            birth_year: birth_year,
            created_at: Time.current,
            updated_at: Time.current,
            survey_code: encuesta_code,
            housing_unit: vivienda_code,
            common_key: common_key,
          }

          row_count += 1

          if personas.size >= BATCH_SIZE
            NewPersona.insert_all(personas)
            personas.clear
          end
        end

        # Insert remaining rows
        NewPersona.insert_all(personas) if personas.any?
      end

      render json: { message: "Successfully imported #{row_count} personas" }, status: :ok
    rescue StandardError => e
      render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
    end
  end
  
  def export_municipality_data_batch

    batch_size = params[:batch_size].to_i > 0 ? params[:batch_size].to_i : 10
    batch_number = params[:batch].to_i >= 0 ? params[:batch].to_i : 0
  
    unique_codes = Municipio.select(:department_code, :muncipality_code).distinct.order(:department_code, :muncipality_code)
  
    batch_codes = unique_codes.offset(batch_number * batch_size).limit(batch_size)
  
    age_groups = Persona.age_groups.keys
  
    csv_data = CSV.generate(headers: true) do |csv|
      csv << ['City', 'Age Group', 'Total count', 'Male count', 'Female count']
  
      batch_codes.each do |code|
        municipality_name = Municipio
                              .where(department_code: code.department_code, muncipality_code: code.muncipality_code)
                              .limit(1)
                              .pluck(:muncipality)
                              .first || 'Unknown'
  
        age_groups.each do |age_name|
          age_value = Persona.age_groups[age_name]
  
          scope = Persona.where(
            department_code: code.department_code,
            muncipality_code: code.muncipality_code,
            age_group: age_value
          )
  
          total = scope.count
          male = scope.where(gender: 1).count
          female = scope.where(gender: 2).count
  
          csv << [municipality_name, age_name.humanize, total, male, female]
        end
      end
    end
  
    send_data csv_data, filename: "municipality_age_group_counts_batch_#{batch_number}.csv"
  end 


  def create_bulk_dane_codes
    if params[:file].nil?
      render json: { error: 'No file uploaded' }, status: :bad_request
      return
    end

    begin
      xls_file = params[:file].tempfile
      spreadsheet = Roo::Spreadsheet.open(xls_file)
      sheet = spreadsheet.sheet(0)

      header = sheet.row(1)
      dane_index = header.index("DANE_CODE")

      if dane_index.nil?
        render json: { error: 'DANE_CODE column not found in file' }, status: :bad_request
        return
      end

      ActiveRecord::Base.transaction do
        sheet.each_row_streaming(offset: 1) do |row|
          next if row.compact.empty?

          dane_value = row[dane_index]&.value
          next if dane_value.nil?

          DaneCodeTesting.create!(
            dane_code_anm: dane_value.to_s
          )
        end
      end

      render json: { message: 'DANE_CODE imported successfully' }, status: :ok

    rescue StandardError => e
      render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
    end
  end

end
