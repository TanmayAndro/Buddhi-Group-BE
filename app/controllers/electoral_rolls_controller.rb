class ElectoralRollsController < ApplicationController
  require 'roo'

  def import
    file = params[:file]
    return render(json: { error: "No file uploaded" }, status: :bad_request) unless file.present?

    xlsx  = Roo::Spreadsheet.open(file.path)
    sheet = xlsx.sheet(0)

    headers       = sheet.row(1).map(&:to_s)
    inserted_rows = 0

    (2..sheet.last_row).each do |i|
      row = Hash[[headers, sheet.row(i)].transpose]

      record = ElectoralRoll.new(
        election_year:                        row["ELECTION_YEAR"],
        election_type:                        row["ELECTION_TYPE"],
        department_code:                      row["DEP_COD"],
        municipality_code:                    row["MUN_COD"],
        voting_zone_code:                     row["ZONE_COD"],
        polling_station_code:                 row["POLLING_COD"],
        department_name:                      row["DEP_NAME"],
        municipality_name:                    row["MUN_NAME"],
        polling_station_name:                 row["POLLING_NAME"],
        women:                                row["WOMEN"],
        men:                                  row["MEN"],
        total:                                row["TOTAL"],
        total_polling_tables_at_station:      row["TABLES"],
        district:                             row["DISTRIC"],
        polling_station_address:              row["ADDRESS"]
      )

      inserted_rows += 1 if record.save
    end

    render json: { message: "Import completed", inserted: inserted_rows }
  end

  def import_votes
    file         = params[:file]
    voting_round = params[:voting_round]

    return render(json: { error: "No file uploaded" }, status: :bad_request) unless file.present?
    return render(json: { error: "voting_round is required" }, status: :bad_request) unless voting_round.present?

    tmp_file = Rails.root.join("tmp", file.original_filename)
    File.open(tmp_file, "wb") { |f| f.write(file.read) }

    ImportVotesJob.perform_later(tmp_file.to_s, voting_round)

    render json: { message: "File upload received. Import is running in background." }
  end

  def import_polling_station
    file = params[:file]
    return render(json: { error: "No file uploaded" }, status: :bad_request) unless file.present?

    xlsx  = Roo::Spreadsheet.open(file.path)
    sheet = xlsx.sheet(0)

    headers       = sheet.row(1).map(&:to_s)
    inserted_rows = 0

    (2..sheet.last_row).each do |i|
      row = Hash[[headers, sheet.row(i)].transpose]

      record = PollingStation.new(
        election_year:                                   row["ELECTION_YEAR"],
        election_type:                                   row["ELECTION_TYPE"],
        department_name:                                 row["DEP_NAME"],
        municipality_name:                               row["MUN_NAME"],
        polling_station_name:                            row["POLLING_NAME"],
        district:                                        row["DISTRIC"],
        district_code:                                   row["DISTRIC_CODE"],
        latitude:                                        row["LAT"],
        longitude:                                       row["LONG"],
        is_mayor_elected_at_this_station:                row["MAYOR"],
        is_governor_elected_at_this_station:             row["GOBERN"],
        is_municipal_council_elected:                    row["COUNCIL"],
        is_department_assembly_elected:                  row["ASSEMBLY"],
        is_local_administrative_board:                   row["JAL"],
        total_number_of_election_type_at_the_station:    row["ELECTIONS_NUMBER"]
      )

      inserted_rows += 1 if record.save
    end

    render json: { message: "Import completed", inserted: inserted_rows }
  end

  def update_polling_station_name_from_electoral_roll
    year = 2018
    puts "Updating polling_station_name for election_year #{year}..."

    sql = <<-SQL
      UPDATE votes
      SET polling_station_name = er.polling_station_name
      FROM electoral_rolls er
      WHERE votes.election_year = #{year}
        AND er.election_year = #{year}
        AND votes.department_code = er.department_code
        AND votes.municipality_code = er.municipality_code
        AND votes.voting_zone_code = er.voting_zone_code
        AND votes.polling_station_code = er.polling_station_code
        AND votes.polling_station_name IS NULL
    SQL

    result = ActiveRecord::Base.connection.execute(sql)
    puts "Done! Updated polling_station_name for #{year}"
  end
  
  def generate_new_polling_id_fast
    puts "Updating new_polling_id using a single SQL query..."

    ActiveRecord::Base.connection.execute(<<~SQL)
      UPDATE new_votes
      SET new_polling_id =
        CONCAT(
          COALESCE(department_code, ''),
          COALESCE(municipality_code, ''),
          COALESCE(polling_station_code, ''),
          REPLACE(TRIM(polling_station_name), ' ', '-')
        )
      WHERE polling_station_name IS NOT NULL;
    SQL

    puts "Completed super-fast update!"
  end
end
