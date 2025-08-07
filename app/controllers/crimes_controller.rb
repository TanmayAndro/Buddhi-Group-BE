class CrimesController < ApplicationController
  
  def create_bulk_crimes
  if params[:file].nil?
    render json: { error: 'No file uploaded' }, status: :bad_request
    return
  end

  begin
    xls_file = params[:file].tempfile
    spreadsheet = Roo::Spreadsheet.open(xls_file)
    sheet = spreadsheet.sheet(0)

    records = []

    sheet.each_with_index do |row, index|
      next if index == 0 || row.compact.empty?

      department   = row[1].to_s.strip
      municipality = row[2].to_s.strip

      # Skip rows where department or municipality is missing
      next if department.blank? || municipality.blank?

      # Normalize weapons_types
      weapons_types = begin
        str = row[4].to_s.strip.upcase
        (str.blank? || str == '-' || str == 'NO REPORTA') ? 'NO REPORTADO' : str.titleize
      end

      # Normalize gender
      gender = begin
        str = row[6].to_s.strip.upcase
        (str.blank? || str == '-' || str == 'NO REPORTA') ? 'NO REPORTADO' : str.titleize
      end

      # Normalize age_group
      age_group = begin
        str = row[7].to_s.gsub('*', '').strip.upcase
        (str.blank? || str == '-' || str == 'NO REPORTA') ? 'NO REPORTADO' : str.titleize
      end

      # Default quantity to 0 if nil or blank
      quantity = row[8].to_i rescue 0

      records << {
        crime_type:     row[0].to_s.strip,     # DELITO
        department:     department,            # DEPARTAMENTO
        municipality:   municipality,          # MUNICIPIO
        dane_code:      row[3].to_s.strip,     # CODIGO DANE
        weapons_types:  weapons_types,         # ARMAS MEDIOS
        incident_date:  row[5],                # FECHA HECHO
        gender:         gender,                # GENERO
        age_group:      age_group,             # AGRUPA EDAD PERSONA
        quantity:       quantity               # CANTIDAD
      }

      if records.size >= 1000
        NewCrime.insert_all(records)
        records.clear
      end
    end

    NewCrime.insert_all(records) if records.any?

    render json: { message: 'Crimes uploaded successfully in bulk' }, status: :ok
  rescue => e
    render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
  end
end


    def crime_incidence_rate
      crime_type = params[:crime_type]
      year = params[:year].to_i
      municipality_code = params[:municipality_code].to_i
      department_code = params[:department_code].to_i

      if crime_type.blank? || year.zero? || (municipality_code.zero? && department_code.zero?)
        return render json: { error: "Missing parameters" }, status: :bad_request
      end
      total_crimes = NewCrime.where(crime_type: crime_type, municipality_code: municipality_code, department_code: department_code,  year: year).sum(:quantity)
      total_population = Persona.where(muncipality_code: municipality_code, department_code: department_code).count

      return render json: { error: "No population data found" }, status: :not_found if total_population.zero?

      rate_per_100k = (total_crimes.to_f / total_population) * 100_000

      render json: {
        crime_type: crime_type,
        year: year,
        total_crimes: total_crimes,
        total_population: total_population,
        incidence_rate_per_100k: rate_per_100k.round(2)
      }
    end

    def crime_distribution_by_gender
      crime_type = params[:crime_type]
      gender = params[:gender]
      year = params[:year].to_i
       municipality_code = params[:municipality_code].to_i
      department_code = params[:department_code].to_i

      if crime_type.blank? || gender.blank? || year.zero? || (municipality_code.zero? && department_code.zero?)
        return render json: { error: "Missing location parameters" }, status: :bad_request
      end

      gender_crime_count = NewCrime.where(
        municipality_code: municipality_code,
        department_code: department_code,
        crime_type: crime_type,
        gender: gender,
        year: year
      ).sum(:quantity)

      total_gender_crimes = NewCrime.where(
        municipality_code: municipality_code,
        department_code: department_code,
        gender: gender,
        year: year
      ).sum(:quantity)

      if total_gender_crimes.zero?
        return render json: { error: "No crime data found for this gender in the given year" }, status: :not_found
      end

      proportion = (gender_crime_count.to_f / total_gender_crimes) * 100

      render json: {
        crime_type: crime_type,
        gender: gender,
        year: year,
        gender_crime_count: gender_crime_count,
        total_gender_crimes: total_gender_crimes,
        proportion_percent: proportion.round(2)
      }
    end

    def crime_distribution_by_age_group
      crime_type = params[:crime_type]
      age_group = params[:age_group]
      year = params[:year].to_i
      municipality_code = params[:municipality_code].to_i
      department_code = params[:department_code].to_i

      if crime_type.blank? || age_group.blank? || year.zero? || (municipality_code.zero? && department_code.zero?)
        return render json: { error: "Missing parameters" }, status: :bad_request
      end

      # Matching age group + crime type
      age_group_crime_count = NewCrime.where(
        municipality_code: municipality_code,
        department_code: department_code,
        crime_type: crime_type,
        age_group: age_group,
        year: year
      ).sum(:quantity)

      # All crimes for that age group in that year & location
      total_age_group_crimes = NewCrime.where(
        municipality_code: municipality_code,
        department_code: department_code,
        age_group: age_group,
        year: year
      ).sum(:quantity)

      if total_age_group_crimes.zero?
        return render json: { error: "No crime data found for this age group in the given year" }, status: :not_found
      end

      proportion = (age_group_crime_count.to_f / total_age_group_crimes) * 100

      render json: {
        crime_type: crime_type,
        age_group: age_group,
        year: year,
        age_group_crime_count: age_group_crime_count,
        total_age_group_crimes: total_age_group_crimes,
        proportion_percent: proportion.round(2)
      }
    end

    def crime_distribution_by_weapon
      crime_type = params[:crime_type]
      weapon_code = params[:weapon_code].to_i
      year = params[:year].to_i
      municipality_code = params[:municipality_code].to_i
      department_code = params[:department_code].to_i

      if crime_type.blank? || weapon_code.zero? || year.zero? || (municipality_code.zero? && department_code.zero?)
        return render json: { error: "Missing parameters" }, status: :bad_request
      end

      # Crimes of this type, with this weapon, in given year and location
      weapon_crime_count = NewCrime.where(
        crime_type: crime_type,
        weapon_code: weapon_code,
        year: year,
        municipality_code: municipality_code,
        department_code: department_code
      ).sum(:quantity)

      # Total crimes of this type in year and location (any weapon)
      total_crime_count = NewCrime.where(
        crime_type: crime_type,
        year: year,
        municipality_code: municipality_code,
        department_code: department_code
      ).sum(:quantity)

      if total_crime_count.zero?
        return render json: { error: "No crime data found for this type in the given year and location" }, status: :not_found
      end

      proportion = (weapon_crime_count.to_f / total_crime_count) * 100

      render json: {
        crime_type: crime_type,
        weapon_code: weapon_code,
        year: year,
        weapon_crime_count: weapon_crime_count,
        total_crime_count: total_crime_count,
        proportion_percent: proportion.round(2)
      }
    end


  def fetch_new_crime_data
    crime_type = params[:crime_type]
    year = params[:year].to_i
    municipality_code = params[:municipality_code].to_i
    department_code = params[:department_code].to_i

    if crime_type.blank? || year.zero? || municipality_code.zero? || department_code.zero?
      return render json: {
        error: "Missing parameters. 'crime_type', 'year', 'municipality_code', and 'department_code' are required."
      }, status: :bad_request
    end

    crimes = NewCrime.where(
      crime_type: crime_type,
      year: year,
      municipality_code: municipality_code,
      department_code: department_code
    )
    crimes = crimes.where("municipality ILIKE ?", params[:municipality]) if params[:municipality].present?
    crimes = crimes.where(weapons_types: params[:weapons_types]) if params[:weapons_types].present?
    crimes = crimes.where(month: params[:month]) if params[:month].present?
    crimes = crimes.where(gender: params[:gender]) if params[:gender].present?
    crimes = crimes.where(age_group: params[:age_group]) if params[:age_group].present?
    total_quantity = crimes.sum(:quantity)
    render json: { total_quantity: total_quantity }
  end

  def fetch_crime_data
    crime_type = params[:crime_type]
    year = params[:year]
    municipality_code = params[:municipality_code]
    department_code = params[:department_code]

    if crime_type.blank? || year.blank? || department_code.blank?
      render json: { error: 'crime_type, year, and department_code are required' }, status: 400 and return
    end

    model_class_name = "Crime#{crime_type.camelize}"
    begin
      model_class = model_class_name.constantize
    rescue NameError
      render json: { error: 'Invalid crime_type' }, status: 400 and return
    end

    column = year_column(year.to_i)
    unless model_class.column_names.include?(column)
      render json: { error: 'Invalid year' }, status: 400 and return
    end

    records = model_class.where(department_code: department_code)
    records = records.where(municipality_code: municipality_code) if municipality_code.present?

    result = records.map do |record|
      {
        department_code: record.department_code,
        municipality_code: record.municipality_code,
        year => record[column]
      }
    end

    render json: result
  end
  
  private

  def year_column(year)
    {
      2010 => "twenty_ten",
      2011 => "twenty_eleven",
      2012 => "twenty_twelve",
      2013 => "twenty_thirteen",
      2014 => "twenty_fourteen",
      2015 => "twenty_fifteen",
      2016 => "twenty_sixteen",
      2017 => "twenty_seventeen",
      2018 => "twenty_eighteen",
      2019 => "twenty_nineteen",
      2020 => "twenty_twenty",
      2021 => "twenty_twenty_one",
      2022 => "twenty_twenty_two",
      2023 => "twenty_twenty_three",
      2024 => "twenty_twenty_four"
    }[year]
  end
  
  end
  