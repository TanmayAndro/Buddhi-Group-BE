
require 'rails_helper'

RSpec.describe FundamentalIndicator, type: :model do
  describe "consistency with NewPersona" do
    it "matches aggregated counts per dane_code (fast)" do
      GENDER_MAN   = NewPersona.genders["Man"]
      GENDER_WOMAN = NewPersona.genders["Woman"]

      AGE_CHILDREN = [1, 2, 3]
      AGE_ADULT    = [4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
      AGE_SENIOR   = [14, 15, 16, 17, 18, 19, 20, 21]

      persona_agg = NewPersona
        .group(:dane_code_anm)
        .pluck(
          :dane_code_anm,
          Arel.sql("COUNT(*)"),
          Arel.sql("SUM(CASE WHEN gender = #{GENDER_MAN} THEN 1 ELSE 0 END)"),
          Arel.sql("SUM(CASE WHEN gender = #{GENDER_WOMAN} THEN 1 ELSE 0 END)"),
          Arel.sql("SUM(CASE WHEN age_group IN (#{AGE_CHILDREN.join(',')}) THEN 1 ELSE 0 END)"),
          Arel.sql("SUM(CASE WHEN age_group IN (#{AGE_ADULT.join(',')}) THEN 1 ELSE 0 END)"),
          Arel.sql("SUM(CASE WHEN age_group IN (#{AGE_SENIOR.join(',')}) THEN 1 ELSE 0 END)")
        )
        .to_h do |row|
          [
            row[0], # dane_code
            {
              total_person:        row[1].to_i,
              male_count:          row[2].to_i,
              female_count:        row[3].to_i,
              children_count:      row[4].to_i,
              adult_count:         row[5].to_i,
              senior_citizen_count: row[6].to_i
            }
          ]
        end

      total_checked   = 0
      total_matched   = 0
      mismatched_ids  = []

      FundamentalIndicator.find_each(batch_size: 1000) do |indicator|
        dane_code = indicator.dane_code
        aggregated = persona_agg[dane_code]

        next unless aggregated
        total_checked += 1

        if indicator.slice(
            :total_person,
            :male_count,
            :female_count,
            :children_count,
            :adult_count,
            :senior_citizen_count
          ).symbolize_keys == aggregated
          total_matched += 1
        else
          mismatched_ids << indicator.id
        end
      end

      puts "\nTotal checked: #{total_checked}, Matched: #{total_matched}, Mismatched: #{mismatched_ids.count}"
      puts "Mismatched IDs: #{mismatched_ids.take(50).join(', ')}" if mismatched_ids.any?

      expect(mismatched_ids).to be_empty
    end
  end
end

