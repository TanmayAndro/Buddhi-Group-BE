class CalculateAllPrimaryJob < ApplicationJob
  queue_as :default

  def perform
    bulk_update_urbanization_rate
  end

  # def update_primary_indicator(dane_code)
  #   persona_scope = NewPersona.where(dane_code_anm: dane_code)
  #   persona_count = persona_scope.count
  #   viviendas_scope = NewVivienda.where(dane_code_anm: dane_code)
  #   total_viviendas = viviendas_scope.count
  #   hogare_scope = NewHogare.where(dane_code_anm: dane_code)
  #   hogare_count = hogare_scope.count

  #   # Average Household Size
  #   average_household_size = (persona_count.to_f / hogare_count).round(2)

  #   # Sex Ratio
  #   male_count = persona_scope.where(gender: "Man").count
  #   female_count = persona_scope.where(gender: "Woman").count
  #   sex_ratio = ((male_count.to_f / female_count) * 100).round(2)

  #   # Age Dependency Ratio
  #   age_0_14 = [1, 2, 3]
  #   age_15_64 = [4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
  #   age_65_plus = [14, 15, 16, 17, 18, 19, 20, 21]

  #   young = persona_scope.where(age_group: age_0_14).count
  #   elderly = persona_scope.where(age_group: age_65_plus).count
  #   working_age = persona_scope.where(age_group: age_15_64).count

  #   age_dependency_ratio = ((young + elderly).to_f / working_age * 100).round(2)

  #   # Urbanization Rate
  #   urban_units = [1, 2]
  #   urban_population = persona_scope.where(unit_info: urban_units).count
  #   total_population = persona_scope.count

  #   urbanization_rate = ((urban_population.to_f / total_population) * 100).round(2)

  #   # Ethnic Composition
  #   ethnic_composition = {}
  #   NewPersona.ethnicicity_statuses.each do |ethnic_group, value|
  #     group_count = persona_scope.where(ethnicicity_status: value).count
  #     percentage = ((group_count.to_f / persona_count) * 100).round(2)
  #     ethnic_composition[ethnic_group] = percentage
  #   end

  #   # Fertility Rate
  #   reproductive_age_groups = (4..10).to_a
  #   women_scope = persona_scope.where(gender: 2, age_group: reproductive_age_groups)

  #   valid_children_values = NewPersona.total_children.values.map(&:to_i) - [99, 100]
  #   live_births = women_scope.where(total_children: valid_children_values).sum(:total_children)
  #   women_count = women_scope.count

  #   fertility_rate = ((live_births.to_f / women_count)).round(2) * 1000

  #   # Infant Mortality Rate
  #   valid_children_values = (1..25).to_a
  #   live_births = persona_scope.where(total_children: valid_children_values)
  #                              .sum(:total_children)
  #   infant_deaths = persona_scope.where(total_children: valid_children_values)
  #                                .sum("GREATEST(total_children - COALESCE(children_survived, 0), 0)")

  #   infant_mortality_rate = if live_births > 0
  #     ((infant_deaths.to_f / live_births) * 1000).round(2)
  #   else
  #     0
  #   end

  #   # Migration Rate
  #   migrants_scope = persona_scope.where(birth_place: [2, 3])
  #   migrants_count = migrants_scope.count
  #   migration_rate = ((migrants_count.to_f / persona_count) * 1000).round(2)

  #   # Literacy Rate (15+)
  #   aged_15_plus = persona_scope.where(age_group: 4..21)
  #   total_aged_15_plus = aged_15_plus.count
  #   literate_count = aged_15_plus.where(literacy_rate: NewPersona.pers_literacy_rate_YES).count

  #   literacy_rate = if total_aged_15_plus > 0
  #     ((literate_count.to_f / total_aged_15_plus) * 100).round(2)
  #   else
  #     0.0
  #   end

  #   # Gross Enrollment Ratio
  #   age_group_ids = [2, 3]
  #   primary_age_group = persona_scope.where(age_group: age_group_ids)
  #   primary_age_group_count = primary_age_group.count
  #   primary_enrollment_count = primary_age_group.where(highest_education: "Primary basic").count

  #   gross_enrollment_ratio = if primary_age_group_count > 0
  #     ((primary_enrollment_count.to_f / primary_age_group_count) * 100).round(2)
  #   else
  #     0.0
  #   end

  #   # Unemployment Rate
  #   labor_force = persona_scope.where(activity_status: [1, 2, 3, 4])
  #   labor_force_count = labor_force.count
  #   unemployed_count = labor_force.where(activity_status: 4).count

  #   unemployment_rate = if labor_force_count > 0
  #     ((unemployed_count.to_f / labor_force_count) * 100).round(2)
  #   else
  #     0.0
  #   end

  #   # Employment-to-Population Ratio
  #   working_age_population = persona_scope.where(age_group: 4..16)
  #   working_age_count = working_age_population.count
  #   employed_count = working_age_population.where(activity_status: [1, 2, 3]).count

  #   employment_to_population_ratio = if working_age_count > 0
  #     ((employed_count.to_f / working_age_count) * 100).round(2)
  #   else
  #     0.0
  #   end

  #   # Access to Improved Water Source
  #   total_households = viviendas_scope.select(:number_of_homes).count
  #   households_with_improved_water = viviendas_scope.where(aquaduct_availability: true).select(:number_of_homes).count

  #   access_to_improved_water_source = if total_households > 0
  #     ((households_with_improved_water.to_f / total_households) * 100).round(2)
  #   else
  #     0.0
  #   end

  #   # Access to Improved Sanitation
  #   households_with_improved_sanitation = viviendas_scope
  #     .where(sanitory_quality: [1, 2])
  #     .select(:number_of_homes)
  #     .count

  #   access_to_improved_sanitation = if total_households > 0
  #     ((households_with_improved_sanitation.to_f / total_households) * 100).round(2)
  #   else
  #     0.0
  #   end

  #   # Electricity Access Rate
  #   households_with_electricity = viviendas_scope
  #     .where(electricity_availability: true)
  #     .select(:number_of_homes)
  #     .count

  #   electricity_access_rate = if total_households > 0
  #     ((households_with_electricity.to_f / total_households) * 100).round(2)
  #   else
  #     0.0
  #   end

  #   # Internet Access Rate
  #   internet_access_count = viviendas_scope
  #     .where(internet_availability: true)
  #     .select(:number_of_homes)
  #     .count

  #   internet_access_rate = if total_households > 0
  #     ((internet_access_count.to_f / total_households) * 100).round(2)
  #   else
  #     0.0
  #   end

  #   # Update PrimaryIndicator if it exists
  #   primary_indicator = PrimaryIndicator.find_by(dane_code: dane_code)

  #   if primary_indicator
  #     primary_indicator.update!(
  #       average_household_size: average_household_size,
  #       sex_ratio: sex_ratio,
  #       age_dependency_ratio: age_dependency_ratio,
  #       urbanization_rate: urbanization_rate,
  #       ethnic_composition: ethnic_composition,
  #       fertility_rate: fertility_rate,
  #       infant_mortality_rate: infant_mortality_rate,
  #       migration_rate: migration_rate,
  #       literacy_rate_over_15: literacy_rate,
  #       gross_enrollment_ratio: gross_enrollment_ratio,
  #       unemployment_rate: unemployment_rate,
  #       employment_to_population_ratio: employment_to_population_ratio,
  #       access_to_improved_water_source: access_to_improved_water_source,
  #       access_to_improved_sanitation_rate: access_to_improved_sanitation,
  #       electricity_access_rate: electricity_access_rate,
  #       internet_access_rate: internet_access_rate
  #     )
  #     { status: 'success', message: "PrimaryIndicator updated successfully for DANE code #{dane_code}" }
  #   else
  #     { status: 'error', message: "PrimaryIndicator not found for DANE code #{dane_code}" }
  #   end
  # end

  # def calculate_and_insert_data
  #   total_processed = 0

  #   persona_stats = NewPersona.group(:dane_code_anm).pluck(
  #     :dane_code_anm,
  #     Arel.sql("COUNT(*)"), # total persons
  #     Arel.sql("SUM(CASE WHEN gender = #{NewPersona.genders['Man']} THEN 1 ELSE 0 END)"), # male
  #     Arel.sql("SUM(CASE WHEN gender = #{NewPersona.genders['Woman']} THEN 1 ELSE 0 END)"), # female
  #     Arel.sql("SUM(CASE WHEN age_group IN (1,2,3) THEN 1 ELSE 0 END)"), # young
  #     Arel.sql("SUM(CASE WHEN age_group BETWEEN 4 AND 13 THEN 1 ELSE 0 END)"), # working age
  #     Arel.sql("SUM(CASE WHEN age_group BETWEEN 14 AND 21 THEN 1 ELSE 0 END)"), # elderly
  #     Arel.sql("SUM(CASE WHEN unit_info IN (1,2) THEN 1 ELSE 0 END)"), # urban pop
  #     Arel.sql("SUM(CASE WHEN age_group BETWEEN 4 AND 21 THEN 1 ELSE 0 END)"), # aged 15+
  #     Arel.sql("SUM(CASE WHEN age_group BETWEEN 4 AND 21 AND literacy_rate = #{NewPersona.defined_enums["literacy_rate"]["YES"]} THEN 1 ELSE 0 END)"),
  #     Arel.sql("SUM(CASE WHEN age_group IN (2,3) THEN 1 ELSE 0 END)"), # primary age group
  #     Arel.sql("SUM(CASE WHEN age_group IN (2,3) AND highest_education = #{NewPersona.defined_enums['highest_education']['Primary basic']} THEN 1 ELSE 0 END)"), # enrolled in primary
  #     Arel.sql("SUM(CASE WHEN activity_status IN (1,2,3,4) THEN 1 ELSE 0 END)"), # labor force
  #     Arel.sql("SUM(CASE WHEN activity_status = 4 THEN 1 ELSE 0 END)"), # unemployed
  #     Arel.sql("SUM(CASE WHEN age_group BETWEEN 4 AND 16 THEN 1 ELSE 0 END)"), # working age population
  #     Arel.sql("SUM(CASE WHEN age_group BETWEEN 4 AND 16 AND activity_status IN (1,2,3) THEN 1 ELSE 0 END)"), # employed
  #     Arel.sql("SUM(CASE WHEN birth_place IN (2,3) THEN 1 ELSE 0 END)"), # migrants
  #     Arel.sql("SUM(CASE WHEN gender = #{NewPersona.genders['Woman']} AND age_group BETWEEN 4 AND 10 THEN total_children ELSE 0 END)"), # live births (fertility)
  #     Arel.sql("SUM(CASE WHEN gender = #{NewPersona.genders['Woman']} AND age_group BETWEEN 4 AND 10 THEN 1 ELSE 0 END)"), # women fertility
  #     Arel.sql("SUM(total_children)"), # live births (infant mortality)
  #     Arel.sql("SUM(GREATEST(total_children - COALESCE(children_survived, 0), 0))") # infant deaths
  #   ).to_h do |row|
  #     dane_code, *values = row
  #     [dane_code, values]
  #   end

  #   vivienda_stats = NewVivienda.group(:dane_code_anm).pluck(
  #     :dane_code_anm,
  #     Arel.sql("COUNT(*)"),
  #     Arel.sql("SUM(CASE WHEN aquaduct_availability = true THEN 1 ELSE 0 END)"),
  #     Arel.sql("SUM(CASE WHEN sanitory_quality IN (1,2) THEN 1 ELSE 0 END)"),
  #     Arel.sql("SUM(CASE WHEN electricity_availability = true THEN 1 ELSE 0 END)"),
  #     Arel.sql("SUM(CASE WHEN internet_availability = true THEN 1 ELSE 0 END)")
  #   ).to_h { |row| [row[0], row.drop(1)] }

  #   hogar_stats = NewHogare.group(:dane_code_anm).count

  #   ethnic_stats = NewPersona.group(:dane_code_anm, :ethnicicity_status).count
  #   ethnic_by_code = Hash.new { |h, k| h[k] = {} }

  #   ethnic_stats.each do |(dane_code, ethnicicity_status), count|
  #     ethnic_by_code[dane_code][ethnicicity_status.to_s] = count
  #   end

  #   updates = []

  #   persona_stats.each do |dane_code, vals|
  #     vivienda = vivienda_stats[dane_code] || [0, 0, 0, 0, 0]
  #     hogar_count = hogar_stats[dane_code] || 0
  #     ethnic = ethnic_by_code[dane_code] || {}

  #     total_person       = vals[0].to_f
  #     male_count         = vals[1].to_f
  #     female_count       = vals[2].to_f
  #     young              = vals[3].to_f
  #     working_age        = vals[4].to_f
  #     elderly            = vals[5].to_f
  #     urban_pop          = vals[6].to_f
  #     aged_15_plus       = vals[7].to_f
  #     literate_15_plus   = vals[8].to_f
  #     primary_age        = vals[9].to_f
  #     primary_enrolled   = vals[10].to_f
  #     labor_force        = vals[11].to_f
  #     unemployed         = vals[12].to_f
  #     working_age_pop    = vals[13].to_f
  #     employed           = vals[14].to_f
  #     migrants           = vals[15].to_f
  #     live_births_fert   = vals[16].to_f
  #     women_fertility    = vals[17].to_f
  #     live_births_infant = vals[18].to_f
  #     infant_deaths      = vals[19].to_f

  #     dwellings, water, sanitation, electricity, internet = vivienda.map(&:to_f)

  #     average_household_size = hogar_count > 0 ? (total_person / hogar_count).round(2) : 0.0
  #     sex_ratio = female_count > 0 ? ((male_count / female_count) * 100).round(2) : 0.0
  #     age_dependency_ratio = working_age > 0 ? (((young + elderly) / working_age) * 100).round(2) : 0.0
  #     urbanization_rate = total_person > 0 ? ((urban_pop / total_person) * 100).round(2) : 0.0
  #     fertility_rate = women_fertility > 0 ? ((live_births_fert / women_fertility).round(2) * 1000) : 0.0
  #     infant_mortality_rate = live_births_infant > 0 ? ((infant_deaths / live_births_infant) * 1000).round(2) : 0.0
  #     migration_rate = total_person > 0 ? ((migrants / total_person) * 1000).round(2) : 0.0
  #     literacy_rate = aged_15_plus > 0 ? ((literate_15_plus / aged_15_plus) * 100).round(2) : 0.0
  #     gross_enrollment_ratio = primary_age > 0 ? ((primary_enrolled / primary_age) * 100).round(2) : 0.0
  #     unemployment_rate = labor_force > 0 ? ((unemployed / labor_force) * 100).round(2) : 0.0
  #     employment_to_population_ratio = working_age_pop > 0 ? ((employed / working_age_pop) * 100).round(2) : 0.0
  #     access_to_improved_water_source = dwellings > 0 ? ((water / dwellings) * 100).round(2) : 0.0
  #     access_to_improved_sanitation = dwellings > 0 ? ((sanitation / dwellings) * 100).round(2) : 0.0
  #     electricity_access_rate = dwellings > 0 ? ((electricity / dwellings) * 100).round(2) : 0.0
  #     internet_access_rate = dwellings > 0 ? ((internet / dwellings) * 100).round(2) : 0.0

  #     ethnic_composition = ethnic.transform_values { |c| total_person > 0 ? ((c.to_f / total_person) * 100).round(2) : 0.0 }.to_json

  #     updates << ActiveRecord::Base.send(
  #       :sanitize_sql_array,
  #       [
  #         <<-SQL.squish,
  #         UPDATE primary_indicators
  #         SET average_household_size = ?,
  #             sex_ratio = ?,
  #             age_dependency_ratio = ?,
  #             urbanization_rate = ?,
  #             ethnic_composition = ?::jsonb,
  #             fertility_rate = ?,
  #             infant_mortality_rate = ?,
  #             migration_rate = ?,
  #             literacy_rate_over_15 = ?,
  #             gross_enrollment_ratio = ?,
  #             unemployment_rate = ?,
  #             employment_to_population_ratio = ?,
  #             access_to_improved_water_source = ?,
  #             access_to_improved_sanitation_rate = ?,
  #             electricity_access_rate = ?,
  #             internet_access_rate = ?
  #         WHERE dane_code = ?
  #         SQL
  #         average_household_size,
  #         sex_ratio,
  #         age_dependency_ratio,
  #         urbanization_rate,
  #         ethnic_composition,
  #         fertility_rate,
  #         infant_mortality_rate,
  #         migration_rate,
  #         literacy_rate,
  #         gross_enrollment_ratio,
  #         unemployment_rate,
  #         employment_to_population_ratio,
  #         access_to_improved_water_source,
  #         access_to_improved_sanitation,
  #         electricity_access_rate,
  #         internet_access_rate,
  #         dane_code
  #       ]
  #     )
  #   end

  #   PrimaryIndicator.transaction do
  #     updates.each_slice(1000) do |batch|
  #       batch.each { |sql| ActiveRecord::Base.connection.execute(sql) }
  #       total_processed += batch.size
  #     end
  #   end

  #   puts "Bulk updated #{total_processed} PrimaryIndicators"
  # end

  # for primary indicators
  def calculate_and_insert_data
    total_processed = 0

    persona_stats = NewPersona.group(:dane_code_anm).pluck(
      :dane_code_anm,
      Arel.sql("COUNT(*)"), # total persons
      Arel.sql("SUM(CASE WHEN gender = #{NewPersona.genders['Man']} THEN 1 ELSE 0 END)"), # male
      Arel.sql("SUM(CASE WHEN gender = #{NewPersona.genders['Woman']} THEN 1 ELSE 0 END)"), # female
      Arel.sql("SUM(CASE WHEN age_group IN (1,2,3) THEN 1 ELSE 0 END)"), # young
      Arel.sql("SUM(CASE WHEN age_group BETWEEN 4 AND 13 THEN 1 ELSE 0 END)"), # working age
      Arel.sql("SUM(CASE WHEN age_group BETWEEN 14 AND 21 THEN 1 ELSE 0 END)"), # elderly
      Arel.sql("SUM(CASE WHEN unit_info IN (1,2) THEN 1 ELSE 0 END)"), # urban pop
      Arel.sql("SUM(CASE WHEN age_group BETWEEN 4 AND 21 THEN 1 ELSE 0 END)"), # aged 15+
      Arel.sql("SUM(CASE WHEN age_group BETWEEN 4 AND 21 AND literacy_rate = #{NewPersona.defined_enums["literacy_rate"]["YES"]} THEN 1 ELSE 0 END)"),
      Arel.sql("SUM(CASE WHEN age_group IN (2,3) THEN 1 ELSE 0 END)"), # primary age group
      Arel.sql("SUM(CASE WHEN age_group IN (2,3) AND highest_education = #{NewPersona.defined_enums['highest_education']['Primary basic']} THEN 1 ELSE 0 END)"), # enrolled in primary
      Arel.sql("SUM(CASE WHEN activity_status IN (1,2,3,4) THEN 1 ELSE 0 END)"), # labor force
      Arel.sql("SUM(CASE WHEN activity_status = 4 THEN 1 ELSE 0 END)"), # unemployed
      Arel.sql("SUM(CASE WHEN age_group BETWEEN 4 AND 16 THEN 1 ELSE 0 END)"), # working age population
      Arel.sql("SUM(CASE WHEN age_group BETWEEN 4 AND 16 AND activity_status IN (1,2,3) THEN 1 ELSE 0 END)"), # employed
      Arel.sql("SUM(CASE WHEN birth_place IN (2,3) THEN 1 ELSE 0 END)"), # migrants
      Arel.sql("SUM(CASE WHEN gender = #{NewPersona.genders['Woman']} AND age_group BETWEEN 4 AND 10 THEN total_children ELSE 0 END)"), # live births (fertility)
      Arel.sql("SUM(CASE WHEN gender = #{NewPersona.genders['Woman']} AND age_group BETWEEN 4 AND 10 THEN 1 ELSE 0 END)"), # women fertility
      Arel.sql("SUM(total_children)"), # live births (infant mortality)
      Arel.sql("SUM(GREATEST(total_children - COALESCE(children_survived, 0), 0))") # infant deaths
    ).to_h do |row|
      dane_code, *values = row
      [dane_code, values]
    end

    vivienda_stats = NewVivienda.group(:dane_code_anm).pluck(
      :dane_code_anm,
      Arel.sql("COUNT(*)"),
      Arel.sql("SUM(CASE WHEN aquaduct_availability = true THEN 1 ELSE 0 END)"),
      Arel.sql("SUM(CASE WHEN sanitory_quality IN (1,2) THEN 1 ELSE 0 END)"),
      Arel.sql("SUM(CASE WHEN electricity_availability = true THEN 1 ELSE 0 END)"),
      Arel.sql("SUM(CASE WHEN internet_availability = true THEN 1 ELSE 0 END)")
    ).to_h { |row| [row[0], row.drop(1)] }

    hogar_stats = NewHogare.group(:dane_code_anm).count

    ethnic_stats = NewPersona.group(:dane_code_anm, :ethnicicity_status).count
    ethnic_by_code = Hash.new { |h, k| h[k] = {} }
    ethnic_stats.each do |(dane_code, ethnicicity_status), count|
      ethnic_by_code[dane_code][ethnicicity_status.to_s] = count
    end

    updates = []

    persona_stats.each do |dane_code, vals|
      vivienda = vivienda_stats[dane_code] || [0, 0, 0, 0, 0]
      hogar_count = hogar_stats[dane_code] || 0
      ethnic = ethnic_by_code[dane_code] || {}

      total_person = vals[0].to_f
      male_count = vals[1].to_f
      female_count = vals[2].to_f
      young = vals[3].to_f
      working_age = vals[4].to_f
      elderly = vals[5].to_f
      urban_pop = vals[6].to_f
      aged_15_plus = vals[7].to_f
      literate_15_plus = vals[8].to_f
      primary_age = vals[9].to_f
      primary_enrolled = vals[10].to_f
      labor_force = vals[11].to_f
      unemployed = vals[12].to_f
      working_age_pop = vals[13].to_f
      employed = vals[14].to_f
      migrants = vals[15].to_f
      live_births_fert = vals[16].to_f
      women_fertility = vals[17].to_f
      live_births_infant = vals[18].to_f
      infant_deaths = vals[19].to_f

      dwellings, water, sanitation, electricity, internet = vivienda.map(&:to_f)

      average_household_size = hogar_count > 0 ? (total_person / hogar_count).round(2) : 0.0
      sex_ratio = female_count > 0 ? ((male_count / female_count) * 100).round(2) : 0.0
      age_dependency_ratio = working_age > 0 ? (((young + elderly) / working_age) * 100).round(2) : 0.0
      urbanization_rate = total_person > 0 ? ((urban_pop / total_person) * 100).round(2) : 0.0
      fertility_rate = women_fertility > 0 ? ((live_births_fert / women_fertility).round(2) * 1000) : 0.0
      infant_mortality_rate = live_births_infant > 0 ? ((infant_deaths / live_births_infant) * 1000).round(2) : 0.0
      migration_rate = total_person > 0 ? ((migrants / total_person) * 1000).round(2) : 0.0
      literacy_rate = aged_15_plus > 0 ? ((literate_15_plus / aged_15_plus) * 100).round(2) : 0.0
      gross_enrollment_ratio = primary_age > 0 ? ((primary_enrolled / primary_age) * 100).round(2) : 0.0
      unemployment_rate = labor_force > 0 ? ((unemployed / labor_force) * 100).round(2) : 0.0
      employment_to_population_ratio = working_age_pop > 0 ? ((employed / working_age_pop) * 100).round(2) : 0.0
      access_to_improved_water_source = dwellings > 0 ? ((water / dwellings) * 100).round(2) : 0.0
      access_to_improved_sanitation = dwellings > 0 ? ((sanitation / dwellings) * 100).round(2) : 0.0
      electricity_access_rate = dwellings > 0 ? ((electricity / dwellings) * 100).round(2) : 0.0
      internet_access_rate = dwellings > 0 ? ((internet / dwellings) * 100).round(2) : 0.0

      ethnic_composition = ethnic.transform_values { |c| total_person > 0 ? ((c.to_f / total_person) * 100).round(2) : 0.0 }.to_json

      updates << ActiveRecord::Base.send(
        :sanitize_sql_array,
        [
          <<-SQL.squish,
            UPDATE primary_indicators
            SET average_household_size = ?,
                sex_ratio = ?,
                age_dependency_ratio = ?,
                urbanization_rate = ?,
                ethnic_composition = ?::jsonb,
                fertility_rate = ?,
                infant_mortality_rate = ?,
                migration_rate = ?,
                literacy_rate_over_15 = ?,
                gross_enrollment_ratio = ?,
                unemployment_rate = ?,
                employment_to_population_ratio = ?,
                access_to_improved_water_source = ?,
                access_to_improved_sanitation_rate = ?,
                electricity_access_rate = ?,
                internet_access_rate = ?
            WHERE dane_code = ?
          SQL
          average_household_size,
          sex_ratio,
          age_dependency_ratio,
          urbanization_rate,
          ethnic_composition,
          fertility_rate,
          infant_mortality_rate,
          migration_rate,
          literacy_rate,
          gross_enrollment_ratio,
          unemployment_rate,
          employment_to_population_ratio,
          access_to_improved_water_source,
          access_to_improved_sanitation,
          electricity_access_rate,
          internet_access_rate,
          dane_code
        ]
      )
    end

    PrimaryIndicator.transaction do
      updates.each_slice(1000) do |batch|
        batch.each { |sql| ActiveRecord::Base.connection.execute(sql) }
        total_processed += batch.size
      end
    end

    puts "Bulk updated #{total_processed} PrimaryIndicators"
  end

  # for urbanization rate
  def bulk_update_urbanization_rate
    total_processed = 0

    persona_stats = NewPersona.group(:dane_code_anm).pluck(
      :dane_code_anm,
      Arel.sql("COUNT(*)"), # total persons
      Arel.sql("SUM(CASE WHEN unit_info IN (1,2) THEN 1 ELSE 0 END)") # urban pop
    ).to_h do |row|
      dane_code, total_person, urban_pop = row
      [dane_code, [total_person.to_f, urban_pop.to_f]]
    end

    updates = []

    persona_stats.each do |dane_code, (total_person, urban_pop)|
      urbanization_rate =
        if total_person > 0
          ((urban_pop / total_person) * 100).round(2)
        else
          0.0
        end

      updates << ActiveRecord::Base.send(
        :sanitize_sql_array,
        [
          <<-SQL.squish,
            UPDATE primary_indicators
            SET urbanization_rate = ?
            WHERE dane_code = ?
          SQL
          urbanization_rate,
          dane_code
        ]
      )
    end

    PrimaryIndicator.transaction do
      updates.each_slice(1000) do |batch|
        batch.each { |sql| ActiveRecord::Base.connection.execute(sql) }
        total_processed += batch.size
      end
    end

    puts "Bulk updated urbanization_rate for #{total_processed} PrimaryIndicators"
  end
end
