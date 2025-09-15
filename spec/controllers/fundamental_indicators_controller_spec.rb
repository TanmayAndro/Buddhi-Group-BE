require 'rails_helper'

RSpec.describe FundamentalIndicatorsController, type: :controller do
  before do
    ActiveJob::Base.queue_adapter = :test
  end

  describe "POST #calculate_all" do
    it "enqueues CalculateAllIndicatorsJob" do
      expect {
        post :calculate_all
      }.to have_enqueued_job(CalculateAllIndicatorsJob)

      expect(response).to have_http_status(:accepted)
      expect(JSON.parse(response.body)).to eq(
        { "message" => "📊 Indicator calculation job has been enqueued." }
      )
    end
  end

 describe "GET #fetch_fundamental_indicator_data_fast_sql" do
  let!(:geo) do 
    create(:unique_georreferenciacion,
      id: 460180,
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
    create(:fundamental_indicator,
      id: 461504,
      dane_code: "9977331300100000000000",
      total_person: 322,
      male_count: 170,
      female_count: 152
    )
  end

  context "when column name is invalid" do
    it "returns bad request" do
      post :fetch_fundamental_indicator_data_fast_sql, params: { column: "fake_column" }

      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to eq({ "error" => "Invalid column name" })
    end
  end

  context "when urban_section_code is present" do
    it "groups by block" do
      post :fetch_fundamental_indicator_data_fast_sql, params: { 
        column: "male_count", 
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
      get :fetch_fundamental_indicator_data_fast_sql, params: { 
        column: "male_count", 
        department_code: 99, 
        urban_sector_code: "0000" 
      }

      body = JSON.parse(response.body)
      expect(body["results"].first).to include("urban_section", "total")
    end
  end

  context "when populated_center_code is present" do
    it "groups by urban_sector" do
      get :fetch_fundamental_indicator_data_fast_sql, params: { 
        column: "male_count", 
        department_code: 99, 
        populated_center_code: "000" 
      }

      body = JSON.parse(response.body)
      expect(body["results"].first).to include("urban_sector", "total")
    end
  end

  context "when rural_section_code is present" do
    it "groups by populated_center" do
      get :fetch_fundamental_indicator_data_fast_sql, params: { 
        column: "male_count", 
        department_code: 99, 
        rural_section_code: "01" 
      }

      body = JSON.parse(response.body)
      expect(body["results"].first).to include("populated_center", "total")
    end
  end

  context "when rural_sector_code is present" do
    it "groups by rural_section" do
      get :fetch_fundamental_indicator_data_fast_sql, params: { 
        column: "male_count", 
        department_code: 99, 
        rural_sector_code: "130" 
      }

      body = JSON.parse(response.body)
      expect(body["results"].first).to include("rural_section", "total")
    end
  end

  context "when unit_info is present" do
    it "groups by rural_sector" do
      get :fetch_fundamental_indicator_data_fast_sql, params: { 
        column: "male_count", 
        department_code: 99, 
        class_code: 3 
      }

      body = JSON.parse(response.body)
      expect(body["results"].first).to include("rural_sector", "total")
    end
  end

  context "when muncipality_code is present" do
    it "groups by unit_info" do
      get :fetch_fundamental_indicator_data_fast_sql, params: { 
        column: "male_count", 
        department_code: 99, 
        muncipality_code: 773 
      }

      body = JSON.parse(response.body)
      expect(body["results"].first).to include("unit_info", "total")
    end
  end

  context "when only department_code is present" do
    it "groups by muncipality_code" do
      get :fetch_fundamental_indicator_data_fast_sql, params: { 
        column: "male_count", 
        department_code: 99
      }

      body = JSON.parse(response.body)
      expect(body["results"].first).to include("muncipality_code", "total")
    end
  end

  context "when no filter params are present" do
    it "groups by department_code" do
      get :fetch_fundamental_indicator_data_fast_sql, params: { column: "male_count" }

      body = JSON.parse(response.body)
      expect(body["results"].first).to include("department_code", "total")
    end
  end
end

end
