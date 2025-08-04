namespace :export do
  desc "Export crimes table to CSV"
  task crimes_csv: :environment do
    require 'csv'

    file_path = Rails.root.join("crimes_backup.csv")
    total_records = Crime.count
    batch_size = 10_000
    total_batches = (total_records.to_f / batch_size).ceil

    puts "Exporting #{total_records} records in #{total_batches} batches to #{file_path}..."

    CSV.open(file_path, "w") do |csv|
      columns = Crime.column_names
      csv << columns

      exported = 0

      Crime.find_in_batches(batch_size: batch_size).with_index(1) do |batch, index|
        batch.each do |crime|
          csv << columns.map { |col| crime.send(col) }
        end

        exported += batch.size
        remaining = total_records - exported
        percent = (exported.to_f / total_records * 100).round(2)

        puts "✅ Batch #{index}/#{total_batches} exported (#{exported} done, #{remaining} left, #{percent}%)"
      end
    end

    puts "🎉 Export complete: #{file_path}"
  end
end
