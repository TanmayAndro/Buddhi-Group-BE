require 'rails_helper'

RSpec.describe NewPersona, type: :model do
  describe "dane_code_anm consistency" do
    it "ensures dane_code_anm matches component fields for all records" do
      total = 0
      matched = 0
      mismatches_count = 0
      mismatches_sample = []

      puts "Total in DB: #{NewPersona.count}"

      NewPersona.find_each(batch_size: 3000) do |record|
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
          mismatches_count += 1
          mismatches_sample << { id: record.id, expected: expected_dane_code, actual: record.dane_code_anm } if mismatches_sample.size < 10
        end
      end

      puts "\n--- Dane Code Verification Report ---"
      puts "Matched: #{matched}"
      puts "Not matched: #{mismatches_count}"
      puts "Total checked: #{total}"
      if mismatches_sample.any?
        puts "\nSample mismatches:"
        mismatches_sample.each do |m|
          puts "Record ##{m[:id]}: expected=#{m[:expected]}, actual=#{m[:actual]}"
        end
      end

      expect(mismatches_count).to eq(0), "#{mismatches_count} records have mismatched dane_code_anm"
    end
  end
end

