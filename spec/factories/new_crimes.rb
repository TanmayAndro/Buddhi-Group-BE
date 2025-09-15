FactoryBot.define do
  factory :new_crime do
    crime_type      { "Homicide" }
    department      { "TestDept" }
    department_code { 10 }
    municipality    { "TestMun" }
    municipality_code { 100 }
    gender          { "Male" }
    age_group       { "18-25" }
    weapons_types   { "Gun" }
    weapon_code     { 1 }
    year            { 2022 }
    month           { 5 }
    quantity        { 3 }
    incident_date   { Date.today }
  end
end
