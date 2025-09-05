class PrimaryIndicatorsController < ApplicationController

	def calculate_all
		CalculateAllPrimaryJob.perform_later
		render json: { message: "📊 primary calculation job has been enqueued." }, status: :accepted
	end	


	def fetch_primary_indicator_data_fast_sql
		department_code        = params[:department_code]
		muncipality_code       = params[:muncipality_code]
		unit_info              = params[:class_code]
		rural_sector_code      = params[:rural_sector_code]
		rural_section_code     = params[:rural_section_code]
		populated_center_code  = params[:populated_center_code]
		urban_sector_code      = params[:urban_sector_code]
		urban_section_code     = params[:urban_section_code]
		column_name            = params[:column]

		unless PrimaryIndicator.column_names.include?(column_name)
			return render json: { error: "Invalid column name" }, status: :bad_request
		end

		group_field =
			if urban_section_code.present?
			:block
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
			:department_code
			end

		query = PrimaryIndicator
			.joins("INNER JOIN unique_georreferenciacions 
					ON unique_georreferenciacions.dane_code_anm = primary_indicators.dane_code")

		query = query.where(unique_georreferenciacions: { department_code: department_code }) if department_code.present?
		query = query.where(unique_georreferenciacions: { muncipality_code: muncipality_code }) if muncipality_code.present?
		query = query.where(unique_georreferenciacions: { unit_info: unit_info }) if unit_info.present?
		query = query.where(unique_georreferenciacions: { rural_sector: rural_sector_code }) if rural_sector_code.present?
		query = query.where(unique_georreferenciacions: { rural_section: rural_section_code }) if rural_section_code.present?
		query = query.where(unique_georreferenciacions: { populated_center: populated_center_code }) if populated_center_code.present?
		query = query.where(unique_georreferenciacions: { urban_sector: urban_sector_code }) if urban_sector_code.present?
		query = query.where(unique_georreferenciacions: { urban_section: urban_section_code }) if urban_section_code.present?

		results = query.group("unique_georreferenciacions.#{group_field}")
						.average("primary_indicators.#{column_name}")

		formatted = results.map do |g, avg|
			{
			group_field => g,
			total: avg.nil? ? nil : avg.to_f.round(2)
			}
		end

		render json: { results: formatted }
	end



end
