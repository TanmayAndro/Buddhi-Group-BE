class GenerateViviendaStatisticsJob < ApplicationJob
  queue_as :default

  def perform
    muncipality_codes = Vivienda.distinct.pluck(:muncipality_code)

    muncipality_codes.each do |code|
      persona_scope = Persona.where(muncipality_code: code)
      persona_count = persona_scope.count
      viviendas_scope = Vivienda.where(muncipality_code: code)
      total_viviendas = viviendas_scope.count

      department_code = persona_scope.where.not(department_code: nil).pluck(:department_code).uniq.first

      # New code start
      total_house_holds = persona_scope.where.not(household_number: nil).count
      average_households = total_house_holds.to_f / total_viviendas

      # House Type
      house_type_counts = Hash.new(0)

      viviendas_scope.find_each(batch_size: 100) do |vivienda|
        house_type_counts[vivienda.house_type] += 1
      end

      house_type_percentages = house_type_counts.transform_values do |count|
        (count.to_f / total_viviendas * 100).round(2)
      end

      percent_of_sewage_access = (viviendas_scope.where.not(sewe_availability: nil).count.to_f / total_viviendas * 100).round(2)
      percent_of_electricity_access = (viviendas_scope.where.not(electricity_availability: nil).count.to_f / total_viviendas * 100).round(2)
      percent_of_internet_access = (viviendas_scope.where.not(internet_availability: nil).count.to_f / total_viviendas * 100).round(2)
      percent_of_gas_connected = (viviendas_scope.where.not(gas_availability: nil).count.to_f / total_viviendas * 100).round(2)
      percent_of_waste_collection = (viviendas_scope.where.not(garbage_disposability: nil).count.to_f / total_viviendas * 100).round(2)

      female_heads = Persona.where(muncipality_code: code).where(relationship_status: 1, gender: 2).count

      percent_of_female_headship = (female_heads.to_f / persona_count * 100).round(2)
      male_count = persona_scope.where(gender: "Man").count
      female_count = persona_scope.where(gender: "Woman").count
      masculnity_ratio = (male_count.to_f / female_count * 100).round(2)
      feminity_ratio = male_count.zero? ? nil : (female_count.to_f / male_count * 100).round(2)

      youth_age_groups = [1, 2, 3]
      elderly_age_groups = (14..21).to_a
      working_age_groups = (4..13).to_a 

      youth_count = persona_scope.where(age_group: youth_age_groups).count
      elderly_count = persona_scope.where(age_group: elderly_age_groups).count
      working_age_count = persona_scope.where(age_group: working_age_groups).count

      # Demographic
      demographic_dependency_ratio = working_age_count.zero? ? nil : ((youth_count + elderly_count).to_f / working_age_count * 100).round(2)

      # Aging
      aging_index = (elderly_count.to_f / youth_count * 100).round(2)

      # Youth
      youth_15_29_age_groups = (4..6).to_a  # age groups: 15–19, 20–24, 25–29
      youth_15_29_count = persona_scope.where(age_group: youth_15_29_age_groups).count
      youth_index = (youth_15_29_count.to_f / persona_count * 100).round(2)

      # Child-Woman Ratio
      under_5_age_groups = [1]
      child_woman_age_groups = (4..10).to_a  # Women aged 15–49

      children_under_5 = persona_scope.where(age_group: under_5_age_groups).count
      women_with_childbearing_age = persona_scope.where(gender: "Woman", age_group: child_woman_age_groups).count

      child_woman_ratio = (children_under_5.to_f / women_with_childbearing_age * 100).round(2)

      # Demographic areas
      geo_counts = {
        "Municipal Headquarters" => persona_scope.where(unit_info: 1).count,
        "Populated Center" => persona_scope.where(unit_info: 2).count,
        "Rural Dispersed" => persona_scope.where(unit_info: 3).count
      }

      geo_counts["Rest Rural (2 and 3)"] = geo_counts["Populated Center"] + geo_counts["Rural Dispersed"]

      distribution_in_geographic_areas = geo_counts.transform_values do |count|
        persona_count.zero? ? 0.0 : (count.to_f / persona_count * 100).round(2)
      end

      # Population distribution by ethnicity and culture
      ethnicity_counts = {
        "Indigenous?" => persona_scope.where(ethnicicity_status: 1).count,
        "Gypsy or Rom?" => persona_scope.where(ethnicicity_status: 2).count,
        "Raizal of the Archipelago of San Andrés, Providencia and Santa Catalina?" => persona_scope.where(ethnicicity_status: 3).count,
        "Palenquero from San Basilio?" => persona_scope.where(ethnicicity_status: 4).count,
        "Black, Mulatto, Afro-descendant, Afro-Colombian?" => persona_scope.where(ethnicicity_status: 5).count,
        "No ethnic group" => persona_scope.where(ethnicicity_status: 6).count,
        "Does not inform" => persona_scope.where(ethnicicity_status: 9).count
      }

      population_distribution_by_ethnic_and_cultural = ethnicity_counts.transform_values do |count|
        (count.to_f / persona_count * 100).round(2)
      end

      # Population by place of birth
      birth_place_counts = {
        "In this mine" => persona_scope.where(birth_place: 1).count,
        "In another Colombian city" => persona_scope.where(birth_place: 2).count,
        "In another country" => persona_scope.where(birth_place: 3).count,
        "Does not inform" => persona_scope.where(birth_place: 9).count,
        "Not applicable" => persona_scope.where(birth_place: 10).count
      }

      population_by_place_of_birth = birth_place_counts.transform_values do |count|
        (count.to_f / persona_count * 100).round(2)
      end

      # Literacy rate
      age_15_and_over_groups = (4..21).to_a
      total_15_plus = persona_scope.where(age_group: age_15_and_over_groups).count
      literate_15_plus = persona_scope.where(age_group: age_15_and_over_groups, literacy_rate: 1).count

      literacy_rate_15_plus = (literate_15_plus.to_f / total_15_plus * 100).round(2)

      # School attendance rate
      total_5_to_14 = persona_scope.where(age_group: [2, 3]).count
      total_15_to_64 = persona_scope.where(age_group: 4..6).count
      total_above_64 = persona_scope.where(age_group: 7..21).count

      attending_5_to_14 = persona_scope.where(age_group: [2, 3], school_presence: 1).count

      numerator = (attending_5_to_14.to_f / total_5_to_14)

      denominator = total_5_to_14 + total_15_to_64 + total_above_64

      school_attendance_rate = (numerator * 100).round(2)

      # Life difficulty
      difficulties_count = persona_scope.where(life_difficulty: 1).count
      person_with_difficulties = (difficulties_count.to_f / persona_count * 100).round(2)

      # Seeking employment
      age_18_and_over_groups = (4..21).to_a

      total_18_and_over = persona_scope.where(age_group: age_18_and_over_groups).count

      seeking_employment_count = persona_scope.where(age_group: age_18_and_over_groups, activity_status: 4).count

      economically_active_population = (seeking_employment_count.to_f / total_18_and_over * 100).round(2)

      # Labor force
      labor_force_age_groups = (4..21).to_a
      working_age_population = persona_scope.where(age_group: labor_force_age_groups)
      employed_count = working_age_population.where(activity_status: [1, 2, 3]).count
      unemployed_count = working_age_population.where(activity_status: 4).count
      labor_force_total = employed_count + unemployed_count
      umeployment_rate = (unemployed_count.to_f / labor_force_total * 100).round(2)

      # Infant mortality rate
      fertile_females = persona_scope.where(gender: "Woman", age_group: 15..49)

      valid_mothers = fertile_females
                        .where.not(total_children: [99, 100])  # 99: No info, 100: Not applicable
                        .where.not(children_survived: [99, 27])  # 99: No info, 27: Not applicable

      total_births = valid_mothers.sum { |p| p.total_children.to_i }
      total_survived = valid_mothers.sum { |p| p.children_survived.to_i }
      total_deaths = total_births - total_survived

      infant_mortality_rate = (total_deaths.to_f / total_births * 1000).round(2)

      # Fertility rate
      fertile_females = persona_scope.where(gender: "Woman").where(age_group: age_18_and_over_groups)

      valid_mothers = fertile_females.where.not(total_children: [99, 100])  # 99: No info, 100: Not applicable

      total_births = valid_mothers.sum { |p| p.total_children.to_i }

      total_women = fertile_females.count

      fertility_rate = (total_births.to_f / total_women * 1000).round(2)

      ViviendaStatistic.create!(
        muncipality_code: code,
        department_code: department_code,
        average_households: average_households,
        percent_of_dwelling_type: house_type_percentages,
        percent_of_sewage_access: percent_of_sewage_access,
        percent_of_electricity_access: percent_of_electricity_access,
        percent_of_internet_access: percent_of_internet_access,
        percent_of_gas_connected: percent_of_gas_connected,
        percent_of_waste_collection: percent_of_waste_collection,
        percent_of_female_headship: percent_of_female_headship,
        masculnity_ratio: masculnity_ratio,
        feminity_ratio: feminity_ratio,
        demographic_dependency_ratio: demographic_dependency_ratio,
        aging_index: aging_index,
        youth_index: youth_index,
        child_woman_ratio: child_woman_ratio,
        distribution_in_geographic_areas: distribution_in_geographic_areas,
        population_distribution_by_ethnic_and_cultural: population_distribution_by_ethnic_and_cultural,
        population_by_place_of_birth: population_by_place_of_birth,
        literacy_rate_over_15: literacy_rate_15_plus,
        school_attendance_rate: school_attendance_rate,
        person_with_difficulties: person_with_difficulties,
        economically_active_population: economically_active_population,
        umeployment_rate: umeployment_rate,
        infant_mortality_rate: infant_mortality_rate,
        fertility_rate: fertility_rate
      )
    end
  end
end
