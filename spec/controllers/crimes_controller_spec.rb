require "rails_helper"

RSpec.describe "Crimes API", type: :request do
 let!(:crime)   { create(:new_crime) }
  let!(:persona) { create(:persona) }
  describe "GET /crime_incidence_rate" do
    it "returns error if missing params" do
    post "/crime_incidence_rate", params: {}
    expect(response).to have_http_status(:bad_request)
    end

    it "returns error if no population data found" do
    # Crime exists but persona does not match these codes
    post "/crime_incidence_rate", params: { crime_type: "Homicide", year: 2022, municipality_code: 999, department_code: 999 }
    expect(response).to have_http_status(:not_found)
    body = JSON.parse(response.body)
    expect(body).to include("error" => "No population data found")
    end

    it "returns incidence rate if data exists" do
    post "/crime_incidence_rate", params: { crime_type: "Homicide", year: 2022, municipality_code: 100, department_code: 10 }
    expect(response).to have_http_status(:ok)
    body = JSON.parse(response.body)
    expect(body).to include(
      "crime_type" => "Homicide"

    )
    end
  end


  describe "GET /crime_distribution_by_gender" do
    it "returns error if params missing" do
      post "/crime_distribution_by_gender", params: {}
      expect(response).to have_http_status(:bad_request)
    end

    it "returns gender distribution" do
      post "/crime_distribution_by_gender", params: { crime_type: "Homicide", gender: "Male", year: 2022, municipality_code: 100, department_code: 10 }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include("gender_crime_count")
    end
  end

  describe "GET /crime_distribution_by_age_group" do
    it "returns error if params missing" do
      post "/crime_distribution_by_age_group", params: {}
      expect(response).to have_http_status(:bad_request)
    end

    it "returns age group distribution" do
      post "/crime_distribution_by_age_group", params: { crime_type: "Homicide", age_group: "18-25", year: 2022, municipality_code: 100, department_code: 10 }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include("age_group_crime_count")
    end
  end

  describe "GET /crime_distribution_by_weapon" do
    it "returns error if params missing" do
      post "/crime_distribution_by_weapon", params: {}
      expect(response).to have_http_status(:bad_request)
    end

    it "returns weapon distribution" do
      post "/crime_distribution_by_weapon", params: { crime_type: "Homicide", weapon_code: 1, year: 2022, municipality_code: 100, department_code: 10 }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include("weapon_crime_count")
    end
  end

  describe "GET /fetch_new_crime_data" do
    it "returns error if params missing" do
      post "/fetch_new_crime_data", params: {}
      expect(response).to have_http_status(:bad_request)
    end

    it "returns total quantity" do
      post "/fetch_new_crime_data", params: { crime_type: "Homicide", year: 2022, municipality_code: 100, department_code: 10 }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include("total_quantity")
    end
  end

  describe "GET /fetch_crime_data" do
    it "returns error if year column does not exist" do
      post "/fetch_crime_data", params: { crime_type: "Homicide", year: 1999, department_code: 10 }
      expect(response).to have_http_status(400)
      body = JSON.parse(response.body)
      expect(body).to include("error" => "Invalid year")
    end

    it "returns error if crime_type missing" do
      post "/fetch_crime_data", params: {}
      expect(response).to have_http_status(400)
    end

    it "returns invalid crime_type if model missing" do
      post "/fetch_crime_data", params: { crime_type: "InvalidType", year: 2022, department_code: 10 }
      expect(response).to have_http_status(400)
    end
  end

  describe "GET /crime_type_stats" do
    it "returns error if params missing" do
      post "/crime_type_stats", params: {}
      expect(response).to have_http_status(:bad_request)
    end

    it "returns department stats" do
      post "/crime_type_stats", params: { crime_type: "Homicide", filter_type: "department" }
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body).to include("by_gender")
    end

    it "returns yearly stats when filter_type is year" do
      post "/crime_type_stats", params: { crime_type: "Homicide", filter_type: "year" }
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body).to include("filter_type" => "year")
      expect(body).to include("yearly_gender_totals", "by_age_group", "by_department", "by_weapons")
    end

    it "returns monthly stats when filter_type is month" do
      post "/crime_type_stats", params: { crime_type: "Homicide", filter_type: "month" }
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body).to include("filter_type" => "month")
      expect(body).to include("by_gender", "by_age_group", "by_department", "by_weapons")
    end

    it "returns stats when filter_type is another valid column (e.g., gender)" do
      post "/crime_type_stats", params: { crime_type: "Homicide", filter_type: "gender" }
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body).to include("filter_type" => "gender")
      expect(body).to include("filter_values", "by_year", "by_month", "by_department")
      expect(body["filter_values"]).to include("Male") # distinct_values check
      expect(body["by_year"]).to be_a(Hash)            # crimes_by_year coverage
      expect(body["by_month"]).to be_a(Hash)           # crimes_by_month coverage
      expect(body["by_department"]).to be_an(Array)    # crimes_by_department coverage
    end
  end

 describe "GET /crime_type_by_years" do
  it "returns error if missing params" do
    post "/crime_type_by_years", params: {}
    expect(response).to have_http_status(:bad_request)
  end

  it "returns error if variable is invalid" do
    post "/crime_type_by_years", params: { crime_type: "Homicide", variable: "invalid_var" }
    expect(response).to have_http_status(400)
    body = JSON.parse(response.body)
    expect(body).to include("error" => "Invalid variable. Allowed: gender, age_group, weapons_types")
  end

  it "returns year breakdown when variable is valid" do
    post "/crime_type_by_years", params: { crime_type: "Homicide", variable: "gender" }
    expect(response).to have_http_status(:ok)
    body = JSON.parse(response.body)
    expect(body).to include("data")
    expect(body["data"].first).to include("year", "total", "breakdown")
  end
end


  describe "GET /crime_type_by_department" do
    it "returns error if missing params" do
      post "/crime_type_by_department", params: {}
      expect(response).to have_http_status(:bad_request)
    end

    it "returns department breakdown" do
      post "/crime_type_by_department", params: { crime_type: "Homicide", variable: "gender" }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include("data")
    end
  end

 describe "GET /crime_type_by_months" do
  it "returns error if missing params" do
    post "/crime_type_by_months", params: {}
    expect(response).to have_http_status(:bad_request)
  end

  it "returns monthly breakdown" do
    post "/crime_type_by_months", params: { crime_type: "Homicide", variable: "gender", year: 2022 }
    expect(response).to have_http_status(:ok)
    body = JSON.parse(response.body)
    expect(body).to include("data")
    expect(body["data"]).to be_an(Array)
    expect(body["data"].size).to eq(12) # ensures filler for all months covered
  end

  it "returns error for invalid variable" do
    post "/crime_type_by_months", params: { crime_type: "Homicide", variable: "invalid", year: 2022 }
    expect(response).to have_http_status(:bad_request)
    body = JSON.parse(response.body)
    expect(body).to include("error" => "Invalid variable. Allowed: gender, age_group, weapons_types")
  end
end


  describe "GET /crime_type_by_municipalities" do
    it "returns error if missing params" do
      post "/crime_type_by_municipalities", params: {}
      expect(response).to have_http_status(:bad_request)
    end

    it "returns municipalities breakdown" do
      post "/crime_type_by_municipalities", params: { crime_type: "Homicide", variable: "gender", department_code: 10 }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include("data")
    end
  end
end
