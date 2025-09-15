FactoryBot.define do
  factory :fundamental_indicator do
    dane_code { "DC#{SecureRandom.hex(2)}" }

    total_person { 0 }
    male_count { 0 }
    female_count { 0 }
    children_count { 0 }
    adult_count { 0 }
    senior_citizen_count { 0 }
    urban_population_count { 0 }
    adult_literacy_count { 0 }
    school_attendance_count { 0 }
    total_population_for_schooling { 0 }
    unemployment_count { 0 }
    total_population_for_work { 0 }
    employment_count { 0 }
    working_age_count { 0 }
    live_births_count { 0 }
    reproductivity_women_no { 0 }

    dwelling_count { 0 }
    senitation_house_count { 0 }
    electricity_house_count { 0 }
    house_holds_with_internet { 0 }
    house_hold_count { 0 }
  end
end
