class CalculateAllIndicatorsJob < ApplicationJob
  queue_as :default

  def perform
   calculate_and_insert_data
  end

  def calculate_and_insert_data
    total_processed = 0

    # Fetch unique dane_codes directly
    dane_codes = FundamentalIndicator.distinct.pluck(:dane_code)

    dane_codes.each do |dane_code|
      indicators = calculate_indicators(dane_code)
      total_processed += 1
    end

    puts "✅ Processed and calculated indicators for #{total_processed} dane_codes."
  end

def calculate_and_insert_data
  total_processed = 0

  # ✅ Precompute persona counts in one big query
  persona_stats = NewPersona.group(:dane_code_anm).pluck(
    :dane_code_anm,
    Arel.sql("COUNT(*)"),
    Arel.sql("SUM(CASE WHEN gender = #{NewPersona.genders['Man']} THEN 1 ELSE 0 END)"),
    Arel.sql("SUM(CASE WHEN gender = #{NewPersona.genders['Woman']} THEN 1 ELSE 0 END)"),
    Arel.sql("SUM(CASE WHEN age_group IN (1,2,3) THEN 1 ELSE 0 END)"),
    Arel.sql("SUM(CASE WHEN age_group BETWEEN 4 AND 13 THEN 1 ELSE 0 END)"),
    Arel.sql("SUM(CASE WHEN age_group BETWEEN 14 AND 21 THEN 1 ELSE 0 END)"),
    Arel.sql("SUM(CASE WHEN unit_info IN (1,2) THEN 1 ELSE 0 END)"),
    Arel.sql("SUM(CASE WHEN age_group BETWEEN 4 AND 21 AND literacy_rate = #{NewPersona.literacy_rates['YES']} THEN 1 ELSE 0 END)"),
    Arel.sql("SUM(CASE WHEN school_presence = #{NewPersona.school_presences['YES']} THEN 1 ELSE 0 END)"),
    Arel.sql("SUM(CASE WHEN age_group IN (2,3,4) THEN 1 ELSE 0 END)"),
    Arel.sql("SUM(CASE WHEN activity_status = #{NewPersona.activity_statuses['Am I looking for work?']} THEN 1 ELSE 0 END)"),
    Arel.sql("SUM(CASE WHEN activity_status IN (1,2,3,4) THEN 1 ELSE 0 END)"),
    Arel.sql("SUM(CASE WHEN activity_status IN (#{NewPersona.activity_statuses['Did you work for at least one hour in an activity that generated some income?']}, #{NewPersona.activity_statuses['Did you work or help in a business for at least one hour without getting paid?']}) THEN 1 ELSE 0 END)"),
    Arel.sql("SUM(CASE WHEN age_group BETWEEN 4 AND 13 THEN 1 ELSE 0 END)"),
    Arel.sql("SUM(CASE WHEN child_birth = #{NewPersona.child_births['YES']} THEN 1 ELSE 0 END)"),
    Arel.sql("SUM(CASE WHEN gender = #{NewPersona.genders['Woman']} AND age_group BETWEEN 4 AND 10 THEN 1 ELSE 0 END)")
  ).to_h do |row|
    dane_code, *values = row
    [dane_code, {
      total_person: values[0],
      male_count: values[1],
      female_count: values[2],
      children_count: values[3],
      adult_count: values[4],
      senior_citizen_count: values[5],
      urban_population_count: values[6],
      adult_literacy_count: values[7],
      school_attendance_count: values[8],
      total_population_for_schooling: values[9],
      unemployment_count: values[10],
      total_population_for_work: values[11],
      employment_count: values[12],
      working_age_count: values[13],
      live_births_count: values[14],
      reproductivity_women_no: values[15]
    }]
  end

  # ✅ Vivienda aggregates
  vivienda_stats = NewVivienda.group(:dane_code_anm).pluck(
    :dane_code_anm,
    Arel.sql("COUNT(*)"),
    Arel.sql("SUM(CASE WHEN sanitory_quality IN (1,2) THEN 1 ELSE 0 END)"),
    Arel.sql("SUM(CASE WHEN electricity_availability = true THEN 1 ELSE 0 END)"),
    Arel.sql("SUM(CASE WHEN internet_availability = true THEN 1 ELSE 0 END)")
  ).to_h do |row|
    [row[0], {
      dwelling_count: row[1],
      senitation_house_count: row[2],
      electricity_house_count: row[3],
      house_holds_with_internet: row[4]
    }]
  end

  # ✅ Household counts
  hogar_stats = NewHogare.group(:dane_code_anm).count

  # ✅ Now update in batch
  FundamentalIndicator.find_each(batch_size: 1000) do |indicator|
    persona = persona_stats[indicator.dane_code] || {}
    vivienda = vivienda_stats[indicator.dane_code] || {}
    hogar_count = hogar_stats[indicator.dane_code] || 0

    indicator.update!(
      **persona,
      **vivienda,
      house_hold_count: hogar_count
    )

    total_processed += 1
  end

  puts "✅ Processed and updated #{total_processed} FundamentalIndicators"
end



  
end
