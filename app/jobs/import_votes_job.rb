class ImportVotesJob < ApplicationJob
  queue_as :default
  BATCH_SIZE = 10_000

  def perform(file_path, voting_round)
    records = []

    CSV.foreach(file_path, headers: true) do |row|
      records << {
        election_year: row["ELECTION_YEAR"].presence,
        election_code: row["ELECTION_CODE"].presence,
        election_description: row["ELECTION_DESC"].presence,
        electoral_process_code: row["PROC_CODE"].presence,
        electoral_process_description: row["PROC_DESC"].presence,
        election_date: row["ELEC_DATE"].presence,
        corporation_code: row["COR_COD"].presence,
        corporation_name: row["COR_NAME"].presence,
        popular_election_code: row["POPULAR_ELECTION_CODE"].presence,
        popular_election_description: row["POPULAR_ELECTION_DESC"].presence,
        constituency_code: row["CIR_COD"].presence,
        constituency_description: row["CIR_DESC"].presence,
        citrep_code: row["CITREP_CODE"].presence,
        citrep_description: row["CITREP_DESC"].presence,
        department_code: row["DEP_COD"].presence,
        department_name: row["DEP_NAME"].presence,
        municipality_code: row["MUN_COD"].presence,
        municipality_name: row["MUN_NAME"].presence,
        voting_zone_code: row["ZONE_COD"].presence,
        polling_station_code: row["POLLING_COD"].presence,
        polling_station_name: row["POLLING_NAME"].presence,
        commune_code: row["COM_CODE"].presence,
        commune_description: row["COM_DESC"].presence,
        polling_table_code: row["TABLE_COD"].presence,
        number_of_votes_recorded: row["NUM_VOTES"].presence,
        political_party_code: row["PART_CODE"].presence,
        political_party_name: row["PART_NAME"].presence,
        candidate_code: row["CAND_CODE"].presence,
        candidate_name: row["CAND_NAME"].presence,
        voting_round: voting_round
      }

      if records.size >= BATCH_SIZE
        NewVote.insert_all(records)
        records.clear
      end
    end

    NewVote.insert_all(records) if records.any?
  end
end
