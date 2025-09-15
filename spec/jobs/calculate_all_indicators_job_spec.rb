require 'rails_helper'

RSpec.describe CalculateAllIndicatorsJob, type: :job do
  let!(:dane_code1) { "9977356300100000000000" }
  let!(:dane_code2) { "9977356300100000000001" }
  let!(:dane_code3) { "9977356300100000000002" }

  let!(:fundamental_indicator1) { create(:fundamental_indicator, dane_code: dane_code1) }
  let!(:fundamental_indicator2) { create(:fundamental_indicator, dane_code: dane_code2) }

  before do
    create(:new_persona,
      dane_code_anm: dane_code1,
      gender: NewPersona.genders['Man'],
      age_group: 2, # child (1,2,3)
      unit_info: 1,
      literacy_rate: NewPersona.literacy_rates['YES'],
      school_presence: NewPersona.school_presences['YES'],
      activity_status: NewPersona.activity_statuses['Am I looking for work?'],
      child_birth: NewPersona.child_births['YES']
    )

    create(:new_persona,
      dane_code_anm: dane_code1,
      gender: NewPersona.genders['Woman'],
      age_group: 5, # adult (4-13)
      unit_info: 2,
      literacy_rate: NewPersona.literacy_rates['YES'],
      school_presence: NewPersona.school_presences['YES'],
      activity_status: NewPersona.activity_statuses['Did you work for at least one hour in an activity that generated some income?'],
      child_birth: NewPersona.child_births['NO']
    )

    create(:new_persona,
      dane_code_anm: dane_code1,
      gender: NewPersona.genders['Woman'],
      age_group: 15, # senior citizen (14-21)
      unit_info: 3,
      literacy_rate: NewPersona.literacy_rates['NO'],
      school_presence: NewPersona.school_presences['NO'],
      activity_status: NewPersona.activity_statuses['Did you work or help in a business for at least one hour without getting paid?'],
      child_birth: NewPersona.child_births['NO']
    )

    # dane_code2
    create(:new_persona,
      dane_code_anm: dane_code2,
      gender: NewPersona.genders['Man'],
      age_group: 1, # child
      unit_info: 1,
      literacy_rate: NewPersona.literacy_rates['NO'],
      school_presence: NewPersona.school_presences['NO'],
      activity_status: NewPersona.activity_statuses['Did you work for at least one hour in an activity that generated some income?'],
      child_birth: NewPersona.child_births['NO']
    )
  end

  # Viviendas covering all branches
  before do
    create(:new_vivienda,
      dane_code_anm: dane_code1,
      sanitory_quality: 1,
      electricity_availability: true,
      internet_availability: true
    )

    create(:new_vivienda,
      dane_code_anm: dane_code1,
      sanitory_quality: 3,
      electricity_availability: false,
      internet_availability: false
    )

    create(:new_vivienda,
      dane_code_anm: dane_code2,
      sanitory_quality: 2,
      electricity_availability: true,
      internet_availability: false
    )
  end

  # Hogares
  before do
    create(:new_hogare, dane_code_anm: dane_code1)
    create(:new_hogare, dane_code_anm: dane_code1)
    create(:new_hogare, dane_code_anm: dane_code2)
  end

  describe "#perform" do
    before { described_class.perform_now }

    it "calculates aggregates for dane_code1 correctly" do
      fundamental_indicator1.reload

      # Persona counts
      expect(fundamental_indicator1.total_person).to eq(3)
      expect(fundamental_indicator1.male_count).to eq(1)
      expect(fundamental_indicator1.female_count).to eq(2)
      expect(fundamental_indicator1.children_count).to eq(1)
      expect(fundamental_indicator1.adult_count).to eq(1)
      expect(fundamental_indicator1.senior_citizen_count).to eq(1)
      expect(fundamental_indicator1.school_attendance_count).to eq(2)
      expect(fundamental_indicator1.unemployment_count).to eq(1)
      expect(fundamental_indicator1.total_population_for_work).to eq(3)
      expect(fundamental_indicator1.employment_count).to eq(2)
      expect(fundamental_indicator1.live_births_count).to eq(1)
      expect(fundamental_indicator1.reproductivity_women_no).to eq(1)

      # Vivienda
      expect(fundamental_indicator1.dwelling_count).to eq(2)
      expect(fundamental_indicator1.senitation_house_count).to eq(1)
      expect(fundamental_indicator1.electricity_house_count).to eq(1)
      expect(fundamental_indicator1.house_holds_with_internet).to eq(1)

      # Hogar
      expect(fundamental_indicator1.house_hold_count).to eq(2)
    end

    it "calculates aggregates for dane_code2 correctly" do
      fundamental_indicator2.reload

      expect(fundamental_indicator2.total_person).to eq(1)
      expect(fundamental_indicator2.male_count).to eq(1)
      expect(fundamental_indicator2.female_count).to eq(0)
      expect(fundamental_indicator2.children_count).to eq(1)
      expect(fundamental_indicator2.adult_count).to eq(0)
      expect(fundamental_indicator2.senior_citizen_count).to eq(0)
      expect(fundamental_indicator2.adult_literacy_count).to eq(0)
      expect(fundamental_indicator2.school_attendance_count).to eq(0)
      expect(fundamental_indicator2.unemployment_count).to eq(0)
      expect(fundamental_indicator2.total_population_for_work).to eq(1)
      expect(fundamental_indicator2.employment_count).to eq(1)
      expect(fundamental_indicator2.live_births_count).to eq(0)
      expect(fundamental_indicator2.reproductivity_women_no).to eq(0)

      expect(fundamental_indicator2.dwelling_count).to eq(1)
      expect(fundamental_indicator2.senitation_house_count).to eq(1)
      expect(fundamental_indicator2.electricity_house_count).to eq(1)
      expect(fundamental_indicator2.house_holds_with_internet).to eq(0)
      expect(fundamental_indicator2.house_hold_count).to eq(1)
    end

    it "handles FundamentalIndicator with no associated data gracefully" do
      indicator_without_data = create(:fundamental_indicator, dane_code: dane_code3)
      indicator_without_data.reload

      expect(indicator_without_data.total_person).to eq(0)
      expect(indicator_without_data.male_count).to eq(0)
      expect(indicator_without_data.female_count).to eq(0)
      expect(indicator_without_data.children_count).to eq(0)
      expect(indicator_without_data.adult_count).to eq(0)
      expect(indicator_without_data.senior_citizen_count).to eq(0)
      expect(indicator_without_data.adult_literacy_count).to eq(0)
      expect(indicator_without_data.school_attendance_count).to eq(0)
      expect(indicator_without_data.total_population_for_schooling).to eq(0)
      expect(indicator_without_data.unemployment_count).to eq(0)
      expect(indicator_without_data.total_population_for_work).to eq(0)
      expect(indicator_without_data.employment_count).to eq(0)
      expect(indicator_without_data.live_births_count).to eq(0)
      expect(indicator_without_data.reproductivity_women_no).to eq(0)

      expect(indicator_without_data.dwelling_count).to eq(0)
      expect(indicator_without_data.senitation_house_count).to eq(0)
      expect(indicator_without_data.electricity_house_count).to eq(0)
      expect(indicator_without_data.house_holds_with_internet).to eq(0)
      expect(indicator_without_data.house_hold_count).to eq(0)
    end
  end
end
