class CsvExportController < ApplicationController
  require "csv"

  def export_single_department(dept_code)
    file_path = Rails.root.join("tmp", "fundamental_indicators_department_#{dept_code}.csv")

    CSV.open(file_path, "w") do |csv|
      csv << [
        "dane_code",
        "total_person",
        "male_count",
        "female_count",
        "indigenous_count",
        "afrodescendants_count",
        "rom_count",
        "raizal_count",
        "age_0_to_18",
        "age_18_to_25",
        "age_26_to_35",
        "age_36_to_45",
        "age_46_to_55",
        "age_56_to_65",
        "age_66_to_75",
        "age_76_plus"
      ]

      age_data = NewPersona
        .where("dane_code_anm LIKE ?", "#{dept_code}%")
        .group(:dane_code_anm)
        .select(
          :dane_code_anm,
          "SUM(CASE WHEN age_group IN (1,2,3,4) THEN 1 ELSE 0 END) AS age_0_to_18",
          "SUM(CASE WHEN age_group IN (5) THEN 1 ELSE 0 END) AS age_18_to_25",
          "SUM(CASE WHEN age_group IN (6,7) THEN 1 ELSE 0 END) AS age_26_to_35",
          "SUM(CASE WHEN age_group IN (8,9) THEN 1 ELSE 0 END) AS age_36_to_45",
          "SUM(CASE WHEN age_group IN (10,11) THEN 1 ELSE 0 END) AS age_46_to_55",
          "SUM(CASE WHEN age_group IN (12,13) THEN 1 ELSE 0 END) AS age_56_to_65",
          "SUM(CASE WHEN age_group IN (14,15) THEN 1 ELSE 0 END) AS age_66_to_75",
          "SUM(CASE WHEN age_group IN (16,17,18,19,20,21) THEN 1 ELSE 0 END) AS age_76_plus"
        )

      age_lookup = age_data.index_by(&:dane_code_anm)

      FundamentalIndicator
        .where("dane_code LIKE ?", "#{dept_code}%")
        .find_each(batch_size: 5000) do |record|

        ethnic = record.ethnic_group_population || {}
        ages   = age_lookup[record.dane_code]

        csv << [
          record.dane_code,
          record.total_person,
          record.male_count,
          record.female_count,
          ethnic["Indigenous?"].to_i,
          ethnic["Black, Mulatto, Afro-descendant, Afro-Colombian?"].to_i,
          ethnic["Gypsy or Rom?"].to_i,
          ethnic["Raizal of the Archipelago of San Andrés, Providencia and Santa Catalina?"].to_i,
          ages&.age_0_to_18.to_i,
          ages&.age_18_to_25.to_i,
          ages&.age_26_to_35.to_i,
          ages&.age_36_to_45.to_i,
          ages&.age_46_to_55.to_i,
          ages&.age_56_to_65.to_i,
          ages&.age_66_to_75.to_i,
          ages&.age_76_plus.to_i
        ]
      end
    end

    puts "✅ Exported department #{dept_code} → #{file_path}"
  end

  def export_single_department_with_new_age_group(dept_code)
    file_path = Rails.root.join("tmp", "fundamental_indicators_department_#{dept_code}.csv")

    CSV.open(file_path, "w") do |csv|
      csv << [
        "dane_code",
        "total_person",
        "male_count",
        "female_count",
        "indigenous_count",
        "rom_count",
        "raizal_count",
        "palenquero_count",
        "afrodescendants_count",
        "no_ethnic_group_count",
        "does_not_inform_count",
        "age_0_to_18",
        "age_18_to_25",
        "age_26_to_35",
        "age_36_to_45",
        "age_46_to_55",
        "age_56_to_65",
        "age_66_to_75",
        "age_76_plus"
      ]

      age_data = NewPersona
        .where("dane_code_anm LIKE ?", "#{dept_code}%")
        .group(:dane_code_anm)
        .select(
          :dane_code_anm,
          "SUM(CASE WHEN new_age_group IN (1,2,3,4) THEN 1 ELSE 0 END) AS age_0_to_18",
          "SUM(CASE WHEN new_age_group IN (5) THEN 1 ELSE 0 END) AS age_18_to_25",
          "SUM(CASE WHEN new_age_group IN (6,7) THEN 1 ELSE 0 END) AS age_26_to_35",
          "SUM(CASE WHEN new_age_group IN (8,9) THEN 1 ELSE 0 END) AS age_36_to_45",
          "SUM(CASE WHEN new_age_group IN (10,11) THEN 1 ELSE 0 END) AS age_46_to_55",
          "SUM(CASE WHEN new_age_group IN (12,13) THEN 1 ELSE 0 END) AS age_56_to_65",
          "SUM(CASE WHEN new_age_group IN (14,15) THEN 1 ELSE 0 END) AS age_66_to_75",
          "SUM(CASE WHEN new_age_group IN (16,17,18,19,20,21) THEN 1 ELSE 0 END) AS age_76_plus"
        )

      age_lookup = age_data.index_by(&:dane_code_anm)

      FundamentalIndicator.where("dane_code LIKE ?", "#{dept_code}%")
                          .find_each(batch_size: 5000) do |record|
        ethnic = record.ethnic_group_population || {}
        ages   = age_lookup[record.dane_code]

        csv << [
          record.dane_code,
          record.total_person.to_i,
          record.male_count.to_i,
          record.female_count.to_i,
          ethnic["Indigenous?"].to_i,
          ethnic["Gypsy or Rom?"].to_i,
          ethnic["Raizal of the Archipelago of San Andrés, Providencia and Santa Catalina?"].to_i,
          ethnic["Palenquero from San Basilio?"].to_i,
          ethnic["Black, Mulatto, Afro-descendant, Afro-Colombian?"].to_i,
          ethnic["No ethnic group"].to_i,
          ethnic["Does not inform"].to_i,
          ages&.age_0_to_18.to_i,
          ages&.age_18_to_25.to_i,
          ages&.age_26_to_35.to_i,
          ages&.age_36_to_45.to_i,
          ages&.age_46_to_55.to_i,
          ages&.age_56_to_65.to_i,
          ages&.age_66_to_75.to_i,
          ages&.age_76_plus.to_i
        ]
      end
    end

    puts "Exported department #{dept_code} → #{file_path}"
  end

end
