require "rails_helper"

RSpec.describe PrimaryIndicatorsController, type: :controller do
  describe "GET #fetch_primary_indicator_data_fast_sql" do
    let!(:geo) do
      create(:unique_georreferenciacion,
        department_code: 99,
        muncipality_code: 773,
        unit_info: 3,
        rural_sector: "130",
        rural_section: "01",
        populated_center: "000",
        urban_sector: "0000",
        urban_section: "00",
        block: "00",
        dane_code_anm: "9977331300100000000000"
      )
    end

    let!(:indicator) do
      create(:primary_indicator,
        dane_code: "9977331300100000000000",
        average_household_size: 43.5,
        literacy_rate_over_15: 84.57,
        unemployment_rate: 25.93,
        infant_mortality_rate: 626.39,
        fertility_rate: 6.94,
        sex_ratio: 111.84,
        age_dependency_ratio: 105.1,
        urbanization_rate: 0.0,
        ethnic_composition: {
          "Indigenous?" => 97.52,
          "Does not inform" => 2.48
        }.to_json,
        migration_rate: 139.75,
        gross_enrollment_ratio: 63.92,
        employment_to_population_ratio: 11.8,
        access_to_improved_water_source: 0.0,
        access_to_improved_sanitation_rate: 0.0,
        electricity_access_rate: 13.9,
        internet_access_rate: 0.0
      )
    end

    context "when column name is invalid" do
      it "returns bad request" do
        post :fetch_primary_indicator_data_fast_sql, params: { column: "fake_column" }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ "error" => "Invalid column name" })
      end
    end

    context "when urban_section_code is present" do
      it "groups by block" do
        post :fetch_primary_indicator_data_fast_sql, params: {
          column: "average_household_size",
          department_code: 99,
          urban_section_code: "00"
        }

        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body["results"].first).to include("block", "total")
      end
    end

    context "when urban_sector_code is present" do
      it "groups by urban_section" do
        post :fetch_primary_indicator_data_fast_sql, params: {
          column: "average_household_size",
          department_code: 99,
          urban_sector_code: "0000"
          
        }

        body = JSON.parse(response.body)
        expect(body["results"].first).to include("urban_section", "total")
      end
    end

    context "when populated_center_code is present" do
      it "groups by urban_sector" do
        post :fetch_primary_indicator_data_fast_sql, params: {
          column: "average_household_size",
          department_code: 99,
          populated_center_code: "000"
        }

        body = JSON.parse(response.body)
        expect(body["results"].first).to include("urban_sector", "total")
      end
    end

    context "when rural_section_code is present" do
      it "groups by populated_center" do
        post :fetch_primary_indicator_data_fast_sql, params: {
          column: "average_household_size",
          department_code: 99,
          rural_section_code: "01"
        }

        body = JSON.parse(response.body)
        expect(body["results"].first).to include("populated_center", "total")
      end
    end

    context "when rural_sector_code is present" do
      it "groups by rural_section" do
        post :fetch_primary_indicator_data_fast_sql, params: {
          column: "average_household_size",
          department_code: 99,
          rural_sector_code: "130"
        }

        body = JSON.parse(response.body)
        expect(body["results"].first).to include("rural_section", "total")
      end
    end

    context "when unit_info is present" do
      it "groups by rural_sector" do
        post :fetch_primary_indicator_data_fast_sql, params: {
          column: "average_household_size",
          department_code: 99,
          class_code: 3
        }

        body = JSON.parse(response.body)
        expect(body["results"].first).to include("rural_sector", "total")
      end
    end

    context "when muncipality_code is present" do
      it "groups by unit_info" do
        post :fetch_primary_indicator_data_fast_sql, params: {
          column: "average_household_size",
          department_code: 99,
          muncipality_code: 773
        }

        body = JSON.parse(response.body)
        expect(body["results"].first).to include("unit_info", "total")
      end
    end

    context "when only department_code is present" do
      it "groups by muncipality_code" do
        post :fetch_primary_indicator_data_fast_sql, params: {
          column: "average_household_size",
          department_code: 99
        }

        body = JSON.parse(response.body)
        expect(body["results"].first).to include("muncipality_code", "total")
      end
    end

    context "when no filter params are present" do
      it "groups by department_code" do
        post :fetch_primary_indicator_data_fast_sql, params: { column: "average_household_size" }

        body = JSON.parse(response.body)
        expect(body["results"].first).to include("department_code", "total")
      end
    end

 
  end

  describe "POST #calculate_all" do
    before do
      ActiveJob::Base.queue_adapter = :test
    end

    it "enqueues CalculateAllPrimaryJob" do
      expect {
        post :calculate_all
      }.to have_enqueued_job(CalculateAllPrimaryJob)

      expect(response).to have_http_status(:accepted)
      expect(JSON.parse(response.body)).to eq(
        { "message" => "📊 primary calculation job has been enqueued." }
      )
    end
  end
end
