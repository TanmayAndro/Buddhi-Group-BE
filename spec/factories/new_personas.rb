FactoryBot.define do
  factory :new_persona do
    dane_code_anm { "DC001" }

    gender { NewPersona.genders.keys.sample } 
    age_group { 5 }
    literacy_rate { NewPersona.literacy_rates.keys.first }
    school_presence { NewPersona.school_presences.keys.first }
    activity_status { NewPersona.activity_statuses.keys.first }
    unit_info { 1 }
    child_birth { NewPersona.child_births.keys.first }
  end
end
