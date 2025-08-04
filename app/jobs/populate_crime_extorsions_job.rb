class PopulateCrimeExtorsionsJob < ApplicationJob
  queue_as :default

  # def perform
  #   years = (2010..2024).to_a

  #   column_map = {
  #     2010 => :twenty_ten,
  #     2011 => :twenty_eleven,
  #     2012 => :twenty_twelve,
  #     2013 => :twenty_thirteen,
  #     2014 => :twenty_fourteen,
  #     2015 => :twenty_fifteen,
  #     2016 => :twenty_sixteen,
  #     2017 => :twenty_seventeen,
  #     2018 => :twenty_eighteen,
  #     2019 => :twenty_nineteen,
  #     2020 => :twenty_twenty,
  #     2021 => :twenty_twenty_one,
  #     2022 => :twenty_twenty_two,
  #     2023 => :twenty_twenty_three,
  #     2024 => :twenty_twenty_four
  #   }

  #   locations = Crime.where(crime_type: "EXTORSIÓN")
  #                    .distinct
  #                    .pluck(:department_code, :municipality_code)

  #   locations.each do |department_code, municipality_code|
  #     extorsion = CrimeExtorsion.find_or_initialize_by(
  #       department_code: department_code,
  #       municipality_code: municipality_code
  #     )

  #     years.each do |year|
  #       start_date = Date.new(year, 1, 1)
  #       end_date = Date.new(year, 12, 31)

  #       count = Crime.where(
  #         department_code: department_code,
  #         municipality_code: municipality_code,
  #         crime_type: "EXTORSIÓN",
  #         incident_date: start_date..end_date
  #       ).count

  #       column = column_map[year]
  #       extorsion[column] = count
  #     end

  #     extorsion.save!
  #   end
  # end


  # def perform
  #   years = (2010..2024).to_a

  #   column_map = {
  #     2010 => :twenty_ten,
  #     2011 => :twenty_eleven,
  #     2012 => :twenty_twelve,
  #     2013 => :twenty_thirteen,
  #     2014 => :twenty_fourteen,
  #     2015 => :twenty_fifteen,
  #     2016 => :twenty_sixteen,
  #     2017 => :twenty_seventeen,
  #     2018 => :twenty_eighteen,
  #     2019 => :twenty_nineteen,
  #     2020 => :twenty_twenty,
  #     2021 => :twenty_twenty_one,
  #     2022 => :twenty_twenty_two,
  #     2023 => :twenty_twenty_three,
  #     2024 => :twenty_twenty_four
  #   }

  #   locations = Crime.where(crime_type: "HOMICIDIO")
  #                   .distinct
  #                   .pluck(:department_code, :municipality_code)

  #   crime_counts = Crime.where(crime_type: "HOMICIDIO", incident_date: Date.new(2010)..Date.new(2024, 12, 31))
  #                       .group(:department_code, :municipality_code, "EXTRACT(YEAR FROM incident_date)")
  #                       .count

  #   locations.each do |department_code, municipality_code|
  #     homicide = CrimeHomicide.find_or_initialize_by(
  #       department_code: department_code,
  #       municipality_code: municipality_code
  #     )

  #     years.each do |year|
  #       count = crime_counts[[department_code, municipality_code, year.to_f]] || 0
  #       column = column_map[year]
  #       homicide[column] = count
  #     end

  #     homicide.save!
  #   end
  # end


#  def perform
#   years = (2010..2024).to_a

#   column_map = {
#     2010 => :twenty_ten,
#     2011 => :twenty_eleven,
#     2012 => :twenty_twelve,
#     2013 => :twenty_thirteen,
#     2014 => :twenty_fourteen,
#     2015 => :twenty_fifteen,
#     2016 => :twenty_sixteen,
#     2017 => :twenty_seventeen,
#     2018 => :twenty_eighteen,
#     2019 => :twenty_nineteen,
#     2020 => :twenty_twenty,
#     2021 => :twenty_twenty_one,
#     2022 => :twenty_twenty_two,
#     2023 => :twenty_twenty_three,
#     2024 => :twenty_twenty_four
#   }

#   locations = Crime.where(crime_type: "HURTO_AUTOMOTORES")
#                    .distinct
#                    .pluck(:department_code, :municipality_code)

#   crime_counts = Crime.where(crime_type: "HURTO_AUTOMOTORES", incident_date: Date.new(2010)..Date.new(2024, 12, 31))
#                       .group(:department_code, :municipality_code, "EXTRACT(YEAR FROM incident_date)")
#                       .count

#   locations.each do |department_code, municipality_code|
#     vehicle_theft_record = CrimeVehicleTheft.find_or_initialize_by(
#       department_code: department_code,
#       municipality_code: municipality_code
#     )

#     years.each do |year|
#       count = crime_counts[[department_code, municipality_code, year.to_f]] || 0
#       column = column_map[year]
#       vehicle_theft_record[column] = count
#     end

#     vehicle_theft_record.save!
#   end
# end

# def perform
#   years = (2010..2024).to_a

#   column_map = {
#     2010 => :twenty_ten,
#     2011 => :twenty_eleven,
#     2012 => :twenty_twelve,
#     2013 => :twenty_thirteen,
#     2014 => :twenty_fourteen,
#     2015 => :twenty_fifteen,
#     2016 => :twenty_sixteen,
#     2017 => :twenty_seventeen,
#     2018 => :twenty_eighteen,
#     2019 => :twenty_nineteen,
#     2020 => :twenty_twenty,
#     2021 => :twenty_twenty_one,
#     2022 => :twenty_twenty_two,
#     2023 => :twenty_twenty_three,
#     2024 => :twenty_twenty_four
#   }

#   # Group crimes by location, demographics, weapon, and year
#   crime_counts = Crime.where(
#                       crime_type: "HURTO_COMERCIO",
#                       incident_date: Date.new(2010)..Date.new(2024, 12, 31)
#                     )
#                     .group(
#                       :department_code,
#                       :municipality_code,
#                       :age_group,
#                       :gender,
#                       :weapons_types,
#                       Arel.sql("EXTRACT(YEAR FROM incident_date)")
#                     )
#                     .count

#   # Save each grouped result into the commercial thefts table
#   crime_counts.each do |(department_code, municipality_code, age_group, gender, weapons_types, year_float), count|
#     year = year_float.to_i
#     column = column_map[year]
#     next unless column  # skip if year not in map

#     # Find or initialize record for this breakdown
#     theft_record = CrimeCommercialTheft.find_or_initialize_by(
#       department_code: department_code,
#       municipality_code: municipality_code,
#       age_group: age_group,
#       gender: gender,
#       weapons_types: weapons_types
#     )

#     # Update the appropriate year column
#     theft_record[column] ||= 0
#     theft_record[column] += count

#     theft_record.save!
#   end
# end

 def perform
    Crime.where.not(incident_date: nil).find_each(batch_size: 10_000) do |crime|
      crime.update_columns(
        year: crime.incident_date.year.to_s,
        month: crime.incident_date.strftime("%m")
      )
    end
  end

end
