require 'rails_helper'

RSpec.describe NewVote, type: :model do
  describe 'new_polling_id correctness' do

    it 'ensures new_polling_id is department_code + municipality_code + polling_station_code + polling_station_name_with_hyphens' do
      matched = 0
      mismatched = 0

      NewVote.find_each do |vote|

        next if vote.department_code.blank? ||
                vote.municipality_code.blank? ||
                vote.polling_station_code.blank? ||
                vote.polling_station_name.blank?

        cleaned_name = vote.polling_station_name.gsub(' ', '-')

        expected_id =
          "#{vote.department_code}" \
          "#{vote.municipality_code}" \
          "#{vote.polling_station_code}" \
          "#{cleaned_name}"

        if vote.new_polling_id == expected_id
          matched += 1
        else
          mismatched += 1

          puts "\n MISMATCH for NewVote id=#{vote.id}"
          puts "Expected: #{expected_id}"
          puts "Actual:   #{vote.new_polling_id}"
          puts "Original Name:     #{vote.polling_station_name}"
          puts "Cleaned Name:      #{cleaned_name}"
          puts "Department:        #{vote.department_code}"
          puts "Municipality:      #{vote.municipality_code}"
          puts "Station Code:      #{vote.polling_station_code}"
          puts "-----------------------------------------------"
        end
      end

      puts "\n=========== SUMMARY ==========="
      puts " Total matched:    #{matched}"
      puts " Total mismatched: #{mismatched}"
      puts "================================\n"

      expect(mismatched).to eq(0), "There are #{mismatched} mismatched new_polling_id records. Check console output above."
    end
  end

  describe 'new_polling_id first 7 digits report' do
    it 'prints how many new_polling_id do NOT start with 7 digits' do
      valid_count = 0
      invalid_count = 0

      NewVote.find_each do |vote|
        next if vote.new_polling_id.blank?

        first_seven = vote.new_polling_id[0, 7]

        if first_seven =~ /\A\d{7}\z/
          valid_count += 1
        else
          invalid_count += 1

          puts "\n Invalid first 7 digits for NewVote id=#{vote.id}"
          puts "new_polling_id: #{vote.new_polling_id}"
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

 
  describe 'updated_candidate_list frequency per election_year' do
    it 'prints how many times each candidate appears in each election_year' do
      years = NewVote.distinct.pluck(:election_year)

      years.each do |year|
        puts "\n\n==================== CANDIDATE FREQUENCIES FOR #{year} ===================="

        votes = NewVote.where(election_year: year)
        candidates = votes.pluck(:updated_candidate_list)

        frequency = candidates.group_by(&:itself).transform_values(&:count)

        frequency.sort_by { |_, count| -count }.each do |name, count|
          puts "#{name.ljust(40)} : #{count}"
        end

        puts "==========================================================================\n\n"
      end

      expect(true).to eq(true)
    end
  end

  describe 'polling_id address and name consistency' do
    it 'ensures district, polling_station_address, and polling_station_name are unique for each polling_id' do
      inconsistencies = []

      ElectoralRoll.group(:polling_id).pluck(:polling_id).each do |pid|
        rows = ElectoralRoll.where(polling_id: pid)

        next if rows.count < 2 

        districts = rows.pluck(:district).uniq
        addresses = rows.pluck(:polling_station_address).uniq
        names     = rows.pluck(:polling_station_name).uniq

        if districts.size > 1 || addresses.size > 1 || names.size > 1
          inconsistencies << {
            polling_id: pid,
            districts: districts,
            addresses: addresses,
            names: names,
            count: rows.count
          }
        end
      end

      puts "\n=========== POLLING ID ADDRESS & NAME INCONSISTENCIES =========="
      inconsistencies.each do |i|
        puts "\n polling_id = #{i[:polling_id]} (#{i[:count]} records):"
        puts "Districts: #{i[:districts].inspect}"
        puts "Addresses: #{i[:addresses].inspect}"
        puts "Names:     #{i[:names].inspect}"
        puts "-------------------------------------------------------------"
      end
      puts "================================================================\n"

      expect(inconsistencies).to be_empty,
        "Found #{inconsistencies.count} polling_ids where district/address/name differ. See console output."
    end
  end
end
