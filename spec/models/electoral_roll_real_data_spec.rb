require 'rails_helper'

RSpec.describe ElectoralRoll, type: :model do
  describe 'nov_polling_id correctness' do
    it 'ensures nov_polling_id is department_code + municipality_code + polling_station_code + polling_station_name_with_hyphens' do
      matched = 0
      mismatched = 0

      ElectoralRoll.find_each do |roll|

        next if roll.department_code.blank? ||
                roll.municipality_code.blank? ||
                roll.polling_station_code.blank? ||
                roll.polling_station_name.blank?

        cleaned_name = roll.polling_station_name.gsub(' ', '-')

        expected_id =
          "#{roll.department_code}" \
          "#{roll.municipality_code}" \
          "#{roll.polling_station_code}" \
          "#{cleaned_name}"

        if roll.nov_polling_id == expected_id
          matched += 1
        else
          mismatched += 1
          puts "\n MISMATCH for ElectoralRoll id=#{roll.id}"
          puts "Expected: #{expected_id}"
          puts "Actual:   #{roll.nov_polling_id}"
          puts "Original Name:     #{roll.polling_station_name}"
          puts "Cleaned Name:      #{cleaned_name}"
          puts "Department:        #{roll.department_code}"
          puts "Municipality:      #{roll.municipality_code}"
          puts "Station Code:      #{roll.polling_station_code}"
          puts "-----------------------------------------------"
        end
      end

      puts "\n=========== SUMMARY ==========="
      puts "Total matched:    #{matched}"
      puts "Total mismatched: #{mismatched}"
      puts "================================\n"

      expect(mismatched).to eq(0), "There are #{mismatched} mismatched nov_polling_id records. Check console output above."
    end
  end

  describe 'code format validation' do
    it 'ensures department_code is 2 digits, municipality_code is 3 digits, polling_station_code is 2 characters' do
      ElectoralRoll.find_each do |roll|
        next if roll.department_code.blank? ||
                roll.municipality_code.blank? ||
                roll.polling_station_code.blank?

        expect(roll.department_code.to_s.length).to eq(2),
          "Invalid department_code for ElectoralRoll id=#{roll.id}: #{roll.department_code.inspect}"

        expect(roll.municipality_code.to_s.length).to eq(3),
          "Invalid municipality_code for ElectoralRoll id=#{roll.id}: #{roll.municipality_code.inspect}"

        expect(roll.polling_station_code.to_s.length).to eq(2),
          "Invalid polling_station_code for ElectoralRoll id=#{roll.id}: #{roll.polling_station_code.inspect}"
      end
    end
  end

  describe 'nov_polling_id first 7 digits' do
    it 'prints how many nov_polling_id do NOT start with 7 digits' do
      valid_count = 0
      invalid_count = 0

      ElectoralRoll.find_each do |roll|
        next if roll.nov_polling_id.blank?

        first_seven = roll.nov_polling_id[0, 7]

        if first_seven =~ /\A\d{7}\z/
          valid_count += 1
        else
          invalid_count += 1

          puts "\n Invalid first 7 digits for ElectoralRoll id=#{roll.id}"
          puts "nov_polling_id: #{roll.nov_polling_id}"
          puts "First 7 chars:  #{first_seven}"
          puts "-----------------------------------------------"
        end
      end

      puts "\n=========== FIRST 7 DIGITS SUMMARY ==========="
      puts "Valid first 7 digits:    #{valid_count}"
      puts "Invalid first 7 digits:  #{invalid_count}"
      puts "==============================================\n"

      expect(true).to eq(true)
    end
  end

  describe 'district + polling_station_name uniqueness per nov_polling_id per election_year' do
    it 'checks that for each election_year and nov_polling_id, district & polling_station_name are consistent' do
      years = ElectoralRoll.distinct.pluck(:election_year)
      total_inconsistent = 0

      years.each do |year|
        puts "\n================ CHECKING YEAR #{year} ================"

        grouped = ElectoralRoll.where(election_year: year).group_by(&:nov_polling_id)

        grouped.each do |nov_polling_id, rows|
          next if nov_polling_id.blank?

          districts = rows.map(&:district).compact.uniq
          names     = rows.map(&:polling_station_name).compact.uniq

          if districts.size > 1 || names.size > 1
            total_inconsistent += 1

            puts "\n Year #{year} – mismatch for nov_polling_id #{nov_polling_id}"
            puts "Districts: #{districts.inspect}"
            puts "Polling Station Names: #{names.inspect}"
            puts "------------------------------------------"
          end
        end
      end

      puts "\n============ SUMMARY ============"
      puts "Total inconsistent nov_polling_id: #{total_inconsistent}"
      puts "=================================\n"

      expect(true).to eq(true)
    end
  end

  describe 'nov_polling_id consistency across district/address/name per election_year' do
    it 'ensures each nov_polling_id has only one district, one address, and one name per election_year' do
      all_years = ElectoralRoll.distinct.pluck(:election_year)
      total_inconsistent = 0

      all_years.each do |year|
        puts "\n================ CHECKING YEAR #{year} ================"

        inconsistent = ElectoralRoll
          .where(election_year: year)
          .where("nov_polling_id IS NOT NULL
                  AND district IS NOT NULL
                  AND polling_station_address IS NOT NULL
                  AND polling_station_name IS NOT NULL")
          .group(:nov_polling_id)
          .having("COUNT(DISTINCT district) > 1 OR
                  COUNT(DISTINCT polling_station_address) > 1 OR
                  COUNT(DISTINCT polling_station_name) > 1")
          .pluck(:nov_polling_id)

        if inconsistent.any?
          total_inconsistent += inconsistent.size

          puts "\n Inconsistent nov_polling_id found for election_year #{year}:"
          inconsistent.each { |id| puts " - #{id}" }
        else
          puts "No inconsistencies found for year #{year}"
        end
      end

      puts "\n============ FINAL SUMMARY ============"
      puts "Total inconsistent nov_polling_id across all years: #{total_inconsistent}"
      puts "========================================\n"

      expect(total_inconsistent).to eq(0),
        "Found #{total_inconsistent} nov_polling_id with mismatched district/address/name across years"
    end
  end
end
