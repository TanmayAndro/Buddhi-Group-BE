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

          personas << {
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
            updated_at: Time.current
          }

          row_count += 1

          if personas.size >= BATCH_SIZE
            Persona.insert_all(personas)
            personas.clear
          end
        end

        # Insert remaining rows
        Persona.insert_all(personas) if personas.any?
      end

      render json: { message: "Successfully imported #{row_count} personas" }, status: :ok
    rescue StandardError => e
      render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
    end
  end
end
