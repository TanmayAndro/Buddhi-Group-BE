class ImportVotesJob < ApplicationJob
  queue_as :default
  BATCH_SIZE = 10_000

  def perform(file_path)
    records = []

    CSV.foreach(file_path, headers: true) do |row|
      records << {
        election_year: row["ELECTION_YEAR"].presence,
        election_code: row["ELECTION_CODE"].presence,
        department_code: row["DEP_COD"].presence,
        department_name: row["DEP_NAME"].presence,
        municipality_code: row["MUN_COD"].presence,
        municipality_name: row["MUN_NAME"].presence,
        voting_zone_code: row["ZONE_COD"].presence,
        polling_station_code: row["POLLING_COD"].presence,
        polling_station_name: row["POLLING_NAME"].presence,
        polling_table_code: row["TABLE_COD"].presence,
        corporation_code: row["COR_COD"].presence,
        corporation_name: row["COR_NAME"].presence,
        constituency_code: row["CIR_COD"].presence,
        political_party_code: row["PART_CODE"].presence,
        political_party_name: row["PART_NAME"].presence,
        candidate_code: row["CAND_CODE"].presence,
        candidate_name: row["CAND_NAME"].presence,
        number_of_votes_recorded: row["NUM_VOTES"].presence,
        created_at: Time.current,
        updated_at: Time.current
      }

      if records.size >= BATCH_SIZE
        Vote.insert_all(records)
        records.clear
      end
    end

    Vote.insert_all(records) if records.any?
  end
end
