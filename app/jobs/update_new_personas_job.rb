class UpdateNewPersonasJob < ApplicationJob
  queue_as :default

  BATCH_SIZE = 10_000

  def perform
    updated_count = 0
    not_matched_count = 0

    NewPersona.where(rural_sector: nil).in_batches(of: BATCH_SIZE) do |batch|
      personas = batch.to_a
      common_keys = personas.map(&:common_key).compact.uniq
      marcos = NewMarcoDeGeorreferenciacion.where(common_key: common_keys).index_by(&:common_key)

      updates = []

      personas.each do |persona|
        marco = marcos[persona.common_key]
        if marco
          updates << {
            id: persona.id,
            rural_sector: marco.rural_sector,
            rural_section: marco.rural_section,
            populated_center: marco.populated_center,
            urban_sector: marco.urban_sector,
            urban_section: marco.urban_section,
            block: marco.block,
            dane_code_anm: marco.dane_code_anm
          }
          updated_count += 1
        else
          not_matched_count += 1
        end
      end

      unless updates.empty?
        values = updates.map do |u|
          "(#{u[:id]}, '#{u[:rural_sector]}', '#{u[:rural_section]}', '#{u[:populated_center]}', '#{u[:urban_sector]}', '#{u[:urban_section]}', '#{u[:block]}', '#{u[:dane_code_anm]}')"
        end.join(", ")

        sql = <<-SQL.squish
          UPDATE new_personas AS np SET
            rural_sector = u.rural_sector,
            rural_section = u.rural_section,
            populated_center = u.populated_center,
            urban_sector = u.urban_sector,
            urban_section = u.urban_section,
            block = u.block,
            dane_code_anm = u.dane_code_anm
          FROM (
            VALUES #{values}
          ) AS u(id, rural_sector, rural_section, populated_center, urban_sector, urban_section, block, dane_code_anm)
          WHERE u.id = np.id
        SQL

        ActiveRecord::Base.connection.execute(sql)
      end
    end

    Rails.logger.info "NewPersona Update complete!"
    Rails.logger.info "Total records updated: #{updated_count}"
    Rails.logger.info "Total unmatched records: #{not_matched_count}"
  end
end
