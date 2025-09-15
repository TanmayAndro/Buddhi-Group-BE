FactoryBot.define do
  factory :unique_georreferenciacion do
    dane_code_anm { "DC001" }
    department_code { "D01" }
    muncipality_code { "M01" }
    unit_info { "U01" }
    rural_sector { "R01" }
    rural_section { "RS01" }
    populated_center { "P01" }
    urban_sector { "US01" }
    urban_section { "USec01" }
  end
end
