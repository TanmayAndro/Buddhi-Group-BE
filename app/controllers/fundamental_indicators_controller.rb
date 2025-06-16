class FundamentalIndicatorsController < ApplicationController
	
  def create
    muncipality_codes = Persona.distinct.pluck(:muncipality_code)
    muncipality_codes.each do |code|
      scope = Persona.where(muncipality_code: code)

      department_code = scope.where.not(department_code: nil).pluck(:department_code).uniq.first

      total_dwellings = Vivienda.where(muncipality_code: code).count
      total_occupied_dwellings = Vivienda.where(muncipality_code: code, houses_occupation: [1, 2]).count
      hogare_count = Hogare.where(muncipality_code: code)
      total_house_holds = hogare_count.where.not(household_number: nil).count

      total_population_in_households = scope.where.not(number_of_person_in_household: nil)
      .pluck(:number_of_person_in_household)
      .map(&:to_i)
      .sum

      male_count = scope.where(gender: "Man").count
      female_count = scope.where(gender: "Woman").count
      children_under_five = scope.where(age_group: [1]).count

    under_fifteen = scope.where(age_group: [1, 2, 3]).count
      over_fifteen = scope.where.not(age_group: [1, 2, 3]).count
      fifteen_to_twenty_nine = scope.where(age_group: [4, 5, 6]).count
      fifteen_to_sixty_four = scope.where(age_group: (4..13)).count
      over_sixty_four = scope.where(age_group: (14..21)).count

      women_with_child_wearing_age = scope.where(
        gender: "Woman",
        age_group: (4..10)
      ).count

      sex_ratio = male_count > 0 ? (female_count.to_f / male_count).round(2) : nil

      FundamentalIndicator.create!(
        muncipality_code: code,
        department_code: department_code,
        total_dwellings: total_dwellings,
        total_occupied_dwellings: total_occupied_dwellings,
        total_house_holds: total_house_holds,
        total_population: total_population_in_households,
        male_count: male_count,
        female_count: female_count,
        children_under_five: children_under_five,
        under_fifteen: under_fifteen,
        over_fifteen: over_fifteen,
        fifteen_to_twenty_nine: fifteen_to_twenty_nine,
        fifteen_to_sixty_four: fifteen_to_sixty_four,
        over_sixty_four: over_sixty_four,
        women_with_child_wearing_age: women_with_child_wearing_age,
        sex_ratio: sex_ratio
      
      )
    end

    render json: { status: 'success'
  }
  end

end
