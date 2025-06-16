class PrimaryIndicatorsController < ApplicationController

	def fetch_stat
		muncipality_code = params[:muncipality_code]
		if muncipality_code.blank?
			render json: { error: 'Missing muncipality_code' }, status: :bad_request
			return
		end
		stat = ViviendaStatistic.find_by(muncipality_code: muncipality_code)
		if stat.nil?
			render json: { error: 'No data found for this muncipality_code' }, status: :not_found
			return
		end
	
		# Prepare the response object
		response = {
			muncipality_code: muncipality_code
		}
	
		# Conditionally add fields based on params
		response[:average_households] = stat.average_households if params[:average_households].present?
		response[:percent_of_dwelling_type] = stat.percent_of_dwelling_type if params[:percent_of_dwelling_type].present?
		response[:percent_of_water_supply_access] = stat.percent_of_water_supply_access if params[:percent_of_water_supply_access].present?
		response[:percent_of_sewage_access] = stat.percent_of_sewage_access if params[:percent_of_sewage_access].present?
		response[:percent_of_electricity_access] = stat.percent_of_electricity_access if params[:percent_of_electricity_access].present?
		response[:percent_of_internet_access] = stat.percent_of_internet_access if params[:percent_of_internet_access].present?
		response[:percent_of_gas_connected] = stat.percent_of_gas_connected if params[:percent_of_gas_connected].present?
		response[:percent_of_waste_collection] = stat.percent_of_waste_collection if params[:percent_of_waste_collection].present?
		response[:average_house_hold_size] = stat.average_house_hold_size if params[:average_house_hold_size].present?
		response[:percent_of_house_holds] = stat.percent_of_house_holds if params[:percent_of_house_holds].present?
		response[:percent_of_female_headship] = stat.percent_of_female_headship if params[:percent_of_female_headship].present?
		response[:masculnity_ratio] = stat.masculnity_ratio if params[:masculnity_ratio].present?
		response[:feminity_ratio] = stat.feminity_ratio if params[:feminity_ratio].present?
		response[:demographic_dependency_ratio] = stat.demographic_dependency_ratio if params[:demographic_dependency_ratio].present?
		response[:aging_index] = stat.aging_index if params[:aging_index].present?
		response[:youth_index] = stat.youth_index if params[:youth_index].present?
		response[:child_woman_ratio] = stat.child_woman_ratio if params[:child_woman_ratio].present?
		response[:population_density] = stat.population_density if params[:population_density].present?
		response[:distribution_in_geographic_areas] = stat.distribution_in_geographic_areas if params[:distribution_in_geographic_areas].present?
		response[:population_distribution_by_ethnic_and_cultural] = stat.population_distribution_by_ethnic_and_cultural if params[:population_distribution_by_ethnic_and_cultural].present?
		response[:population_by_place_of_birth] = stat.population_by_place_of_birth if params[:population_by_place_of_birth].present?
		response[:literacy_rate_over_15] = stat.literacy_rate_over_15 if params[:literacy_rate_over_15].present?
		response[:school_attendance_rate] = stat.school_attendance_rate if params[:school_attendance_rate].present?
		response[:person_with_difficulties] = stat.person_with_difficulties if params[:person_with_difficulties].present?
		response[:economically_active_population] = stat.economically_active_population if params[:economically_active_population].present?
		response[:umeployment_rate] = stat.umeployment_rate if params[:umeployment_rate].present?
		response[:infant_mortality_rate] = stat.infant_mortality_rate if params[:infant_mortality_rate].present?
		response[:fertility_rate] = stat.fertility_rate if params[:fertility_rate].present?
		response[:life_expectancy_at_birth] = stat.life_expectancy_at_birth if params[:life_expectancy_at_birth].present?
		response[:housing_tenure_status] = stat.housing_tenure_status if params[:housing_tenure_status].present?
	
		# Return the response as JSON
		render json: response
	end
	

	def create
		muncipality_codes = Vivienda.distinct.pluck(:muncipality_code)
		muncipality_codes.each do |code|
			persona_scope = Persona.where(muncipality_code: code)
			persona_count = persona_scope.count
			viviendas_scope = Vivienda.where(muncipality_code: code)
			total_viviendas = viviendas_scope.count
			hogare_scope = Hogare.where(muncipality_code: code)
			hogare_count = hogare_scope.count
			
			department_code = persona_scope.where.not(department_code: nil).pluck(:department_code).uniq.first

			#Average Household 
			total_house_holds = hogare_scope.where.not(household_number: nil).count
			average_households = total_house_holds.to_f / total_viviendas

			#House Type
			house_type_counts = Hash.new(0) 

			viviendas_scope.each do |vivienda|
				house_type_counts[vivienda.house_type] += 1
			end

			house_type_percentages = house_type_counts.transform_values do |count|
				(count.to_f / total_viviendas * 100).round(2)
			end

			#water start
	
			total_water_source = hogare_scope.where(water_source: nil).count.to_f
			percent_of_water_supply_access = (total_water_source / total_viviendas * 100).round(2)
			#water end

			#sewarage services 
			percent_of_sewage_access = (viviendas_scope.where.not(sewe_availability: nil).count.to_f / total_viviendas * 100).round(2)

			#electricity access
			percent_of_electricity_access = (viviendas_scope.where.not(electricity_availability: nil).count.to_f / total_viviendas * 100).round(2)

			#internet access
			percent_of_internet_access = (viviendas_scope.where.not(internet_availability: nil).count.to_f / total_viviendas * 100).round(2)

			#gas connected 
			percent_of_gas_connected = (viviendas_scope.where.not(gas_availability: nil).count.to_f / total_viviendas * 100).round(2)

			#waste collection
			percent_of_waste_collection = (viviendas_scope.where.not(garbage_disposability: nil).count.to_f / total_viviendas * 100).round(2)

			#average number of individuals per household 
			total_population = hogare_scope.sum(:people_count)
			average_house_hold_size = total_population / hogare_count

			#percentage of households by number of persons
			valid_households = hogare_scope.where.not(people_count: nil)

			grouped_counts = valid_households.group(:people_count).count

			total_valid_households = valid_households.count
			
			percent_of_house_holds = grouped_counts.transform_values do |count|
			((count.to_f / total_valid_households) * 100).round(2)
			end

			#female headships 
			female_heads = persona_scope.where(relationship_status: 1, gender: 2).count
	
			percent_of_female_headship = (female_heads.to_f / hogare_count * 100).round(2)

			male_count = persona_scope.where(gender: "Man").count
			female_count = persona_scope.where(gender: "Woman").count
			#masculnity ratio 
			masculnity_ratio = (male_count.to_f / female_count * 100).round(2)
			#feminity ratio 
			feminity_ratio =  (female_count.to_f / male_count * 100).round(2)
			
			#dependenc 
			youth_age_groups = [1, 2, 3]
			elderly_age_groups = (14..21).to_a
			working_age_groups = (4..13).to_a 
	
			youth_count = persona_scope.where(age_group: youth_age_groups).count
			elderly_count = persona_scope.where(age_group: elderly_age_groups).count
			working_age_count = persona_scope.where(age_group: working_age_groups).count
			#demographic 

			demographic_dependency_ratio = ((youth_count + elderly_count).to_f / working_age_count * 100).round(2)
			#aging 

			aging_index = (elderly_count.to_f / youth_count * 100).round(2)

			#youth 
			youth_15_29_age_groups = (4..6).to_a  # age groups: 15–19, 20–24, 25–29
			youth_15_29_count = persona_scope.where(age_group: youth_15_29_age_groups).count
			youth_index = (youth_15_29_count.to_f / persona_count * 100).round(2)

			#child-woman-ratio 
			under_5_age_groups = [1]
			child_woman_age_groups = (4..10).to_a  # Women aged 15–49

			# Calculate counts
			children_under_5 = persona_scope.where(age_group: under_5_age_groups).count
			women_with_childbearing_age = persona_scope.where(gender: "Woman", age_group: child_woman_age_groups).count

			# Calculate Child-Woman Ratio
			child_woman_ratio = (children_under_5.to_f / women_with_childbearing_age * 100).round(2)

			#demographic areas 
			geo_counts = {
			"Municipal Headquarters" => persona_scope.where(unit_info: 1).count,
			"Populated Center" => persona_scope.where(unit_info: 2).count,
			"Rural Dispersed" => persona_scope.where(unit_info: 3).count
			}

			geo_counts["Rest Rural (2 and 3)"] = geo_counts["Populated Center"] + geo_counts["Rural Dispersed"]

			distribution_in_geographic_areas = geo_counts.transform_values do |count|
				persona_count.zero? ? 0.0 : (count.to_f / persona_count * 100).round(2)
			end

			#population distribution by ethnic and cultural

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

			  #population by place of birth 

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

			  #literacy rate
			age_15_and_over_groups = (4..21).to_a
			total_15_plus = persona_scope.where(age_group: age_15_and_over_groups).count
			literate_15_plus = persona_scope.where(age_group: age_15_and_over_groups, literacy_rate: 1).count

			literacy_rate_15_plus = (literate_15_plus.to_f / total_15_plus * 100).round(2)

			#school rate attendance 

			# total_5_to_14 = persona_scope.where(age_group: [2, 3]).count
			# total_15_to_64 = persona_scope.where(age_group: 4..6).count
			# total_above_64 = persona_scope.where(age_group: 7..21).count
			
			# attending_5_to_14 = persona_scope.where(age_group: [2, 3], school_presence: 1).count
			
			# numerator = (attending_5_to_14.to_f / total_5_to_14)
			
			# denominator = total_5_to_14 + total_15_to_64 + total_above_64
			
			# school_attendance_rate = (numerator * 100).round(2)
			#school rate end (confirmation pending)			

			#life difficulty

			difficulties_count = persona_scope.where(life_difficulty: 1).count
			person_with_difficulties = (difficulties_count.to_f / persona_count * 100).round(2)

			#seeking employment 

			age_18_and_over_groups = (4..21).to_a

			total_18_and_over = persona_scope.where(age_group: age_18_and_over_groups).count

			seeking_employment_count = persona_scope.where(age_group: age_18_and_over_groups, activity_status: [1,2,4]).count

			economically_active_population =  (seeking_employment_count.to_f / total_18_and_over * 100).round(2)

			#labor force
			labor_force_age_groups = (4..21).to_a
			working_age_population = persona_scope.where(age_group: labor_force_age_groups)
			employed_count = working_age_population.where(activity_status: [1, 2, 3]).count
			unemployed_count = working_age_population.where(activity_status: 4).count
			labor_force_total = employed_count + unemployed_count
			umeployment_rate = (unemployed_count.to_f / labor_force_total * 100).round(2)

			#infant mortality rate(pending)

			fertile_females = persona_scope.where(gender: "Woman", age_group: 15..49)

			# 2. Exclude records with unknown or non-applicable values
			# valid_mothers = fertile_females
			# 					.where.not(total_children: [99, 100])  # 99: No info, 100: Not applicable
			# 					.where.not(children_survived: [99, 27])  # 99: No info, 27: Not applicable

			# total_births = valid_mothers.sum { |p| p.total_children.to_i }
			# total_survived = valid_mothers.sum { |p| p.children_survived.to_i }
			# total_deaths = total_births - total_survived

			# infant_mortality_rate = (total_deaths.to_f / total_births * 1000).round(2)

			#fertility rate(pending)

			# age_18_and_over_groups = (4..10).to_a

			# fertile_females = persona_scope.where(gender: "Woman").where(age_group: age_18_and_over_groups)

			# valid_mothers = fertile_females.where.not(total_children: [99, 100])  # 99: No info, 100: Not applicable

			# total_births = valid_mothers.sum { |p| p.total_children.to_i }

			# total_women = fertile_females.count

			# fertility_rate = (total_births.to_f / total_women * 1000).round(2)

			PrimaryIndicator.create!(
				muncipality_code: code,
				department_code: department_code,
				average_households: average_households,
				percent_of_dwelling_type: house_type_percentages,
				percent_of_water_supply_access: percent_of_water_supply_access,
				percent_of_sewage_access: percent_of_sewage_access,
				percent_of_electricity_access: percent_of_electricity_access,
				percent_of_internet_access: percent_of_internet_access,
				percent_of_gas_connected: percent_of_gas_connected,
				percent_of_waste_collection: percent_of_waste_collection,
				average_house_hold_size: average_house_hold_size,
				percent_of_house_holds: percent_of_house_holds,
				percent_of_female_headship: percent_of_female_headship,
				masculnity_ratio: masculnity_ratio,
				feminity_ratio:  feminity_ratio,
				demographic_dependency_ratio: demographic_dependency_ratio,
				aging_index: aging_index,
				youth_index: youth_index,
				child_woman_ratio: child_woman_ratio,
				distribution_in_geographic_areas: distribution_in_geographic_areas,
				population_distribution_by_ethnic_and_cultural: population_distribution_by_ethnic_and_cultural,
				population_by_place_of_birth: population_by_place_of_birth,
				literacy_rate_over_15: literacy_rate_15_plus,
				# school_attendance_rate: school_attendance_rate,
				person_with_difficulties: person_with_difficulties,
				economically_active_population: economically_active_population,
				umeployment_rate: umeployment_rate,
				# infant_mortality_rate: infant_mortality_rate,
				# fertility_rate: fertility_rate
			)
		end
	
		render json: {
			status: 'success',
			message: 'Statistics including female headship percentage and aging index generated successfully'
		}
	end
	

	# def create
	# 	# Call the background job to generate statistics
	# 	GenerateViviendaStatisticsJob.perform_later
	
	# 	# You can optionally show a flash message to notify the user
	# 	render json: { message: "Vivienda statistics generation job has been started." }, status: :accepted
	
	# 	# Redirect or render as needed
	#   end
end
