class ImportVotesJob < ApplicationJob
  queue_as :default
  BATCH_SIZE = 10_000

  def perform(file_path, voting_round)
    records = []

    CSV.foreach(file_path, headers: true) do |row|
      records << {
        election_year: row["ELECTION_YEAR"].presence,
        election_code: row["ELECTION_CODE"].presence,
        election_description: row["ELECTION_DESCRIPTION"].presence,
        electoral_process_code: row["ELECTORAL_PROCESS_CODE"].presence,
        electoral_process_description: row["ELECTORAL_PROCESS_DESCRIPTION"].presence,
        election_date: row["ELECTION_DATE"].presence,
        corporation_code: row["COR_COD"].presence,
        corporation_name: row["COR_NAME"].presence,
        popular_election_code: row["POPULAR_ELECTION_CODE"].presence,
        popular_election_description: row["POPULAR_ELECTION_DESCRIPTION"].presence,
        constituency_code: row["CIR_COD"].presence,
        constituency_description: row["CIR_NAME"].presence,
        citrep_code: row["CITREP_CODE"].presence,
        citrep_description: row["CITREP_DESCRIPTION"].presence,
        department_code: row["DEP_COD"].presence,
        department_name: row["DEP_NAME"].presence,
        municipality_code: row["MUN_COD"].presence,
        municipality_name: row["MUN_NAME"].presence,
        voting_zone_code: row["ZONE_COD"].presence,
        polling_station_code: row["POLLING_COD"].presence,
        polling_station_name: row["POLLING_NAME"].presence,
        commune_code: row["COMMUNE_CODE"].presence,
        commune_description: row["COMMUNE_DESCRIPTION"].presence,
        polling_table_code: row["TABLE_COD"].presence,
        number_of_votes_recorded: row["NUM_VOTES"].presence,
        political_party_code: row["PART_CODE"].presence,
        political_party_name: row["PART_NAME"].presence,
        candidate_code: row["CAND_CODE"].presence,
        candidate_name: row["CAND_NAME"].presence,
        polling_id: row["POLLING_ID"].presence,
        updated_candidate_list: row["UPDATED_CAND_LIST"].presence,
        new_polling_id: row["NEW_POLLING_ID"].presence,
        voting_round: voting_round,
        created_at: Time.current,
        updated_at: Time.current
      }

      if records.size >= BATCH_SIZE
        NewVote.insert_all(records)
        records.clear
      end
    end

    NewVote.insert_all(records) if records.any?
  end
end
