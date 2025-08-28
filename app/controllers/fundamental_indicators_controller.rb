class FundamentalIndicatorsController < ApplicationController
  def calculate_all
    CalculateAllIndicatorsJob.perform_later
    render json: { message: "📊 Indicator calculation job has been enqueued." }, status: :accepted
  end
	

  def rural_sections_data
    department_code        = params[:department_code]
    muncipality_code       = params[:muncipality_code]
    unit_info              = params[:class_code]
    rural_sector_code      = params[:rural_sector_code]
    rural_section_code     = params[:rural_section_code]
    populated_center_code  = params[:populated_center_code]
    urban_sector_code      = params[:urban_sector_code]
    urban_section_code     = params[:urban_section_code]
    column_name            = params[:column]

    unless FundamentalIndicator.column_names.include?(column_name)
      return render json: { error: "Invalid column name" }, status: :bad_request
    end

    # Base query
    scope = NewMarcoDeGeorreferenciacion.all
    scope = scope.where(department_code: department_code) if department_code.present?

    # Apply filters dynamically
    scope = scope.where(muncipality_code: muncipality_code) if muncipality_code.present?
    scope = scope.where(unit_info: unit_info) if unit_info.present?
    scope = scope.where(rural_sector: rural_sector_code) if rural_sector_code.present?
    scope = scope.where(rural_section: rural_section_code) if rural_section_code.present?
    scope = scope.where(populated_center: populated_center_code) if populated_center_code.present?
    scope = scope.where(urban_sector: urban_sector_code) if urban_sector_code.present?
    scope = scope.where(urban_section: urban_section_code) if urban_section_code.present?

    # Decide grouping level
    group_field =
      if urban_section_code.present?
        :urban_section
      elsif urban_sector_code.present?
        :urban_section
      elsif populated_center_code.present?
        :urban_sector
      elsif rural_section_code.present?
        :populated_center
      elsif rural_sector_code.present?
        :rural_section
      elsif unit_info.present?
        :rural_sector
      elsif muncipality_code.present?
        :unit_info
      elsif department_code.present?
        :muncipality_code
      else
        :department_code # ✅ new: if no department_code, group by department
      end

    records = scope.select(group_field, :dane_code_anm).distinct
    dane_codes = records.map(&:dane_code_anm)

    fi_map = FundamentalIndicator
      .where(dane_code: dane_codes)
      .pluck(:dane_code, column_name)
      .to_h

    data = records.group_by(&group_field).map do |group_value, rows|
      total = rows.sum { |row| fi_map[row.dane_code_anm].to_i }
      {
        group_field => group_value,
        total: total
      }
    end

    render json: { results: data }
  end

end
