class PollingStationController < ApplicationController
  def update_department_code
    puts "🚀 Efficiently updating department_code in polling_stations..."

    departments = Vote.distinct.pluck(:department_name, :department_code)

    departments.each_with_index do |(dept_name, dept_code), index|
      PollingStation.where(department_name: dept_name)
                    .update_all(department_code: dept_code)

      puts "✅ (#{index + 1}/#{departments.size}) Updated: #{dept_name}"
    end

    puts "🎯 Completed updating department_code for #{departments.size} departments!"
  end

  def update_municipality_code
    puts "🚀 Updating municipality_code in polling_stations..."

    municipalities = Vote.distinct.pluck(:municipality_name, :municipality_code)

    municipalities.each_with_index do |(muni_name, muni_code), index|
      PollingStation.where(municipality_name: muni_name)
                    .update_all(municipality_code: muni_code)

      puts "✅ (#{index + 1}/#{municipalities.size}) Updated: #{muni_name}"
    end

    puts "🎯 Completed updating municipality_code for #{municipalities.size} municipalities!"
  end
end
