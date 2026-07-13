require 'rails_helper'

RSpec.describe UniqueGeorreferenciacion, type: :model do
  describe "dane_code_anm consistency" do
    it "ensures dane_code_anm matches component fields for all records" do
      mismatches = []
      total = 0
      matched = 0
      puts "Total in DB: #{UniqueGeorreferenciacion.count}"

      UniqueGeorreferenciacion.find_each do |record|
        total += 1
        expected_dane_code = [
          record.department_code.to_s.rjust(2, '0'),
          record.muncipality_code.to_s.rjust(3, '0'),
          record.unit_info.to_s.rjust(1, '0'),
          record.rural_sector.to_s.rjust(3, '0'),
          record.rural_section.to_s.rjust(2, '0'),
          record.populated_center.to_s.rjust(3, '0'),
          record.urban_sector.to_s.rjust(4, '0'),
          record.urban_section.to_s.rjust(2, '0'),
          record.block.to_s.rjust(2, '0')
        ].join

        if record.dane_code_anm == expected_dane_code
          matched += 1
        else
          mismatches << {
            id: record.id,
            expected: expected_dane_code,
            actual: record.dane_code_anm
          }
        end
      end

      if mismatches.any?
        puts "\n--- Dane Code Verification Report ---"
        puts "Matched: #{matched}"
        puts "Not matched: #{mismatches.size}"
        puts "Total checked: #{total}"
        puts "\nSample mismatches:"
        mismatches.first(10).each do |m|
          puts "Record ##{m[:id]}: expected=#{m[:expected]}, actual=#{m[:actual]}"
        end
      else
        puts "\n--- Dane Code Verification Report ---"
        puts "All #{matched} records matched successfully!"
      end

      expect(mismatches).to be_empty, "#{mismatches.size} records have mismatched dane_code_anm"
    end
  end
end

