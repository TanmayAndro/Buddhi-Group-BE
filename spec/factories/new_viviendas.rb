FactoryBot.define do
  factory :new_vivienda do
    dane_code_anm { "DC001" }
    sanitory_quality { 1 }
    electricity_availability { true }
    internet_availability { false }
  end
end
