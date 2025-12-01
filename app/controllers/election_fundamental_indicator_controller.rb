class ElectionFundamentalIndicatorController < ApplicationController

	def update_new_polling_id_from_vote_to_new_election_fundamental_indicator
  	[2014, 2018, 2022].each do |year|
    	puts "🗳️ Starting processing for election year #{year}..."

    	rounds = NewVote.where(election_year: year)
                    .where.not(voting_round: nil)
                    .distinct
                    .pluck(:voting_round)

    puts "🔄 Found rounds #{rounds.inspect} for year #{year}"

    rounds.each do |round|
      puts "➡️ Processing Round #{round} for Year #{year}"

      agg_sql = <<-SQL
        SELECT
          new_polling_id,
          voting_round,
          MAX(election_code) AS election_code,
          MAX(election_year) AS election_year,
          MAX(department_code) AS department_code,
          MAX(municipality_code) AS municipality_code,
          MAX(voting_zone_code) AS zone_code,
          MAX(polling_station_code) AS polling_station_code,
          MAX(polling_station_name) AS polling_station_name,
          MAX(polling_table_code) AS tables,
          MAX(constituency_description) AS distric,
          MAX(political_party_code) AS political_party_code,
          MAX(political_party_name) AS political_party_name,
          MAX(candidate_code) AS candidate_code,
          MAX(updated_candidate_list) AS candidate_name,
          SUM(number_of_votes_recorded) AS total_ballots_cast,
          SUM(
            CASE WHEN updated_candidate_list NOT IN ('VOTOS EN BLANCO', 'VOTO BLANCO',
                                                     'VOTOS NULOS', 'VOTO NULO',
                                                     'NO MARCADOS', 'VOTOS NO MARCADOS')
            THEN number_of_votes_recorded ELSE 0 END
          ) AS valid_votes,
          SUM(CASE WHEN updated_candidate_list IN ('VOTOS EN BLANCO', 'VOTO BLANCO')
              THEN number_of_votes_recorded ELSE 0 END) AS blank_votes,
          SUM(CASE WHEN updated_candidate_list IN ('VOTOS NULOS', 'VOTO NULO')
              THEN number_of_votes_recorded ELSE 0 END) AS null_votes,
          SUM(CASE WHEN updated_candidate_list IN ('NO MARCADOS', 'VOTOS NO MARCADOS')
              THEN number_of_votes_recorded ELSE 0 END) AS unmarked_votes
        FROM new_votes
        WHERE election_year = #{year}
        AND voting_round = '#{round}'
        AND new_polling_id IS NOT NULL
        GROUP BY new_polling_id, voting_round
      SQL

      aggregated = ActiveRecord::Base.connection.exec_query(agg_sql)
      puts "🔹 Found #{aggregated.count} polling stations for #{year} Round #{round}"

      cand_sql = <<-SQL
        SELECT
          new_polling_id,
          voting_round,
          updated_candidate_list,
          SUM(number_of_votes_recorded) AS votes
        FROM new_votes
        WHERE election_year = #{year}
        AND voting_round = '#{round}'
        AND new_polling_id IS NOT NULL
        GROUP BY new_polling_id, voting_round, updated_candidate_list
      SQL

      candidate_data = ActiveRecord::Base.connection.exec_query(cand_sql)

      candidate_map = Hash.new { |h, k| h[k] = [] }

      candidate_data.each do |row|
        name = row['updated_candidate_list'].to_s.strip
        name = case name
               when 'VOTO NULO', 'VOTOS NULOS' then 'VOTOS NULOS'
               when 'VOTO BLANCO', 'VOTOS EN BLANCO' then 'VOTOS EN BLANCO'
               when 'VOTO NO MARCADO', 'VOTOS NO MARCADOS', 'NO MARCADOS'
                 then 'NO MARCADOS'
               else name
               end

        key = "#{row['new_polling_id']}_#{row['voting_round']}"

        candidate_map[key] << {
          candidate: name,
          votes: row['votes'].to_i
        }
      end

      puts "🧩 Starting updates for #{year} Round #{round}..."

      aggregated.each_with_index do |row, idx|
        key = "#{row['new_polling_id']}_#{row['voting_round']}"
        candidate_results = candidate_map[key]

        NewElectionFundamentalIndicator.where(
          new_polling_id: row['new_polling_id'].to_s,
          election_year: year.to_s,
          voting_round: row['voting_round'].to_s
        ).update_all(
          total_ballots_cast: row['total_ballots_cast'].to_i,
          valid_votes: row['valid_votes'].to_i,
          blank_votes: row['blank_votes'].to_i,
          null_votes: row['null_votes'].to_i,
          unmarked_votes: row['unmarked_votes'].to_i,
          election_code: row['election_code'],
          department_code: row['department_code'],
          municipality_code: row['municipality_code'],
          zone_code: row['zone_code'],
          polling_station_code: row['polling_station_code'],
          polling_station_name: row['polling_station_name'],
          tables: row['tables'],
          distric: row['distric'],
          political_party_code: row['political_party_code'],
          political_party_name: row['political_party_name'],
          candidate_code: row['candidate_code'],
          candidate_name: row['candidate_name'],
          candidate_results: candidate_results,
          voting_round: row['voting_round']
        )

        puts "✅ Updated #{idx + 1}/#{aggregated.count} for #{year} Round #{round}" if (idx + 1) % 1000 == 0
      end

      puts "🎯 Completed updates for election year #{year}, round #{round}"
    end
  	end

  	puts "🎉 All election years & rounds updated successfully!"
	end

	def construct_new_polling_id
		ActiveRecord::Base.connection.execute(<<~SQL)
			UPDATE electoral_rolls
			SET new_polling_id = CONCAT(department_code, municipality_code, polling_station_code, polling_station_name);
		SQL
	end

	def update_new_polling_id_from_vote_to_election_fundamental_indicator
		[2014, 2018, 2022].each do |year|
			puts "Processing election year #{year}..."

			polling_ids = Vote.where(election_year: year)
			                  .where.not(new_polling_id: nil)
			                  .distinct
			                  .pluck(:new_polling_id)

			puts "Found #{polling_ids.size} unique polling IDs for #{year}"

			records = polling_ids.map do |pid|
				{
					election_year: year,
					new_polling_id: pid,
					created_at: Time.current,
					updated_at: Time.current
				}
			end

			records.each_slice(1000) do |batch|
				ElectionFundamentalIndicator.insert_all(batch)
			end

			puts "✅ Inserted #{polling_ids.size} records for election_year #{year}"
		end

		puts "🎉 Done creating all ElectionFundamentalIndicator records!"
	end

	def update_dec_polling_id_from_new_polling_id
		puts "🚀 Updating dec_polling_id for all records..."

		ActiveRecord::Base.connection.execute(<<~SQL)
			UPDATE new_election_fundamental_indicators
			SET dec_polling_id = REPLACE(new_polling_id, '-', ' ')
			WHERE new_polling_id IS NOT NULL;
		SQL

		puts "✅ All dec_polling_id values updated successfully!"
	end

	def add_zero_before
		ActiveRecord::Base.connection.execute(<<-SQL)
			UPDATE new_votes
			SET department_code = LPAD(department_code, 2, '0')
			WHERE LENGTH(department_code) = 1;
		SQL

	end


	def update_data_from_electoral_rolls_to_new_election_fundamental_indicator

		[2014, 2018, 2022].each do |year|
			puts "🔵 Updating year #{year}..."

			NewElectionFundamentalIndicator.where(election_year: year).find_each do |record|
			er = ElectoralRoll.find_by(
				election_year: year,
				nov_polling_id: record.new_polling_id
			)

			next unless er

			record.update(
				distric: er.district,
				polling_station_address: er.polling_station_address,
				women: er.women,
				men: er.men,
				total: er.total,
				tables: er.total_polling_tables_at_station

			)
			end

			puts "✔ Finished updating #{year}"
		end

  	puts "🎉 All years processed."
	end

  def export_csv_of_election_fundamental_indicator
    base_dir = Rails.root.join("tmp", "department_exports")
      FileUtils.mkdir_p(base_dir)

     excluded_columns = %w[
      id created_at updated_at zone_code polling_id candidate_results candidate_code political_party_code political_party_name candidate_name dec_polling_id
      lat lon mayor gobern council assembly jal
    ]

      department_codes = NewElectionFundamentalIndicator.distinct.pluck(:department_code)

      department_codes.each do |dept_code|
        years = ElectionFundamentalIndicator
                  .where(department_code: dept_code)
                  .distinct
                  .pluck(:election_year)

        years.each do |yr|
          records = NewElectionFundamentalIndicator.where(department_code: dept_code, election_year: yr)
          next if records.empty?

          file_path = base_dir.join("department_#{dept_code}_year_#{yr}.csv")

          columns = NewElectionFundamentalIndicator.column_names - excluded_columns

          CSV.open(file_path, "w") do |csv|
            csv << columns 

            records.find_each do |record|
              csv << columns.map do |col|
                value = record.send(col)
                value.nil? ? 0 : value
              end
            end
          end

          puts "✅ Exported department #{dept_code} election_year #{yr} → #{file_path}"
        end
      end

      puts "🎉 All 2018 department/year CSVs exported to: #{base_dir}"
  end

  def export_csv_of_election_fundamental_indicator_new
    base_dir = Rails.root.join("tmp", "department_exports")
    FileUtils.mkdir_p(base_dir)

    excluded_columns = %w[
      id created_at updated_at zone_code polling_id candidate_results candidate_code political_party_code political_party_name candidate_name dec_polling_id
      lat lon mayor gobern council assembly jal
    ]

    department_codes = NewElectionFundamentalIndicator.distinct.pluck(:department_code)

    department_codes.each do |dept_code|
      years = NewElectionFundamentalIndicator
                .where(department_code: dept_code)
                .distinct
                .pluck(:election_year)

      years.each do |yr|
        records = NewElectionFundamentalIndicator.where(department_code: dept_code, election_year: yr)
        next if records.empty?

        file_path = base_dir.join("department_#{dept_code}_year_#{yr}.csv")


        original_columns = NewElectionFundamentalIndicator.column_names - excluded_columns


        extra_columns = [
          "candidate_name",
          "party_code",
          "party_name",
          "candidate_code"
        ]

        CSV.open(file_path, "w") do |csv|
          csv << (original_columns + extra_columns)

          records.find_each do |record|

            if record.candidate_results.blank?
              csv << original_columns.map { |col| record.send(col) }
              next
            end

            record.candidate_results.each do |cand|
              candidate_name = cand["candidate"]

              meta = record.meta_for(candidate_name)

              csv << (
                original_columns.map { |col| record.send(col) } +
                [
                  candidate_name,
                  meta ? meta[:party_code] : nil,
                  meta ? meta[:party_name] : nil,
                  meta ? meta[:candidate_code] : nil
                ]
              )
            end
          end
        end

        puts "✅ Exported department #{dept_code} election_year #{yr} → #{file_path}"
      end
    end

    puts "🎉 All department/year CSV exports completed → #{base_dir}"
  end
end