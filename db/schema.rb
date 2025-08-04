# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_08_01_123411) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas_protegidas", force: :cascade do |t|
    t.integer "value"
    t.text "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crime_commercial_thefts", force: :cascade do |t|
    t.integer "department_code"
    t.integer "municipality_code"
    t.integer "twenty_ten", default: 0
    t.integer "twenty_eleven", default: 0
    t.integer "twenty_twelve", default: 0
    t.integer "twenty_thirteen", default: 0
    t.integer "twenty_fourteen", default: 0
    t.integer "twenty_fifteen", default: 0
    t.integer "twenty_sixteen", default: 0
    t.integer "twenty_seventeen", default: 0
    t.integer "twenty_eighteen", default: 0
    t.integer "twenty_nineteen", default: 0
    t.integer "twenty_twenty", default: 0
    t.integer "twenty_twenty_one", default: 0
    t.integer "twenty_twenty_two", default: 0
    t.integer "twenty_twenty_three", default: 0
    t.integer "twenty_twenty_four", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "age_group"
    t.string "gender"
    t.string "weapons_types"
  end

  create_table "crime_delitos_sexuales", force: :cascade do |t|
    t.integer "department_code"
    t.integer "municipality_code"
    t.integer "twenty_ten", default: 0
    t.integer "twenty_eleven", default: 0
    t.integer "twenty_twelve", default: 0
    t.integer "twenty_thirteen", default: 0
    t.integer "twenty_fourteen", default: 0
    t.integer "twenty_fifteen", default: 0
    t.integer "twenty_sixteen", default: 0
    t.integer "twenty_seventeen", default: 0
    t.integer "twenty_eighteen", default: 0
    t.integer "twenty_nineteen", default: 0
    t.integer "twenty_twenty", default: 0
    t.integer "twenty_twenty_one", default: 0
    t.integer "twenty_twenty_two", default: 0
    t.integer "twenty_twenty_three", default: 0
    t.integer "twenty_twenty_four", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crime_domestic_violences", force: :cascade do |t|
    t.integer "department_code"
    t.integer "municipality_code"
    t.integer "twenty_ten", default: 0
    t.integer "twenty_eleven", default: 0
    t.integer "twenty_twelve", default: 0
    t.integer "twenty_thirteen", default: 0
    t.integer "twenty_fourteen", default: 0
    t.integer "twenty_fifteen", default: 0
    t.integer "twenty_sixteen", default: 0
    t.integer "twenty_seventeen", default: 0
    t.integer "twenty_eighteen", default: 0
    t.integer "twenty_nineteen", default: 0
    t.integer "twenty_twenty", default: 0
    t.integer "twenty_twenty_one", default: 0
    t.integer "twenty_twenty_two", default: 0
    t.integer "twenty_twenty_three", default: 0
    t.integer "twenty_twenty_four", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crime_extorsions", force: :cascade do |t|
    t.integer "department_code"
    t.integer "municipality_code"
    t.integer "twenty_ten", default: 0
    t.integer "twenty_eleven", default: 0
    t.integer "twenty_twelve", default: 0
    t.integer "twenty_thirteen", default: 0
    t.integer "twenty_fourteen", default: 0
    t.integer "twenty_fifteen", default: 0
    t.integer "twenty_sixteen", default: 0
    t.integer "twenty_seventeen", default: 0
    t.integer "twenty_eighteen", default: 0
    t.integer "twenty_nineteen", default: 0
    t.integer "twenty_twenty", default: 0
    t.integer "twenty_twenty_one", default: 0
    t.integer "twenty_twenty_two", default: 0
    t.integer "twenty_twenty_three", default: 0
    t.integer "twenty_twenty_four", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crime_financial_institution_thefts", force: :cascade do |t|
    t.integer "department_code"
    t.integer "municipality_code"
    t.integer "twenty_ten", default: 0
    t.integer "twenty_eleven", default: 0
    t.integer "twenty_twelve", default: 0
    t.integer "twenty_thirteen", default: 0
    t.integer "twenty_fourteen", default: 0
    t.integer "twenty_fifteen", default: 0
    t.integer "twenty_sixteen", default: 0
    t.integer "twenty_seventeen", default: 0
    t.integer "twenty_eighteen", default: 0
    t.integer "twenty_nineteen", default: 0
    t.integer "twenty_twenty", default: 0
    t.integer "twenty_twenty_one", default: 0
    t.integer "twenty_twenty_two", default: 0
    t.integer "twenty_twenty_three", default: 0
    t.integer "twenty_twenty_four", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crime_homicides", force: :cascade do |t|
    t.integer "department_code"
    t.integer "municipality_code"
    t.integer "twenty_ten", default: 0
    t.integer "twenty_eleven", default: 0
    t.integer "twenty_twelve", default: 0
    t.integer "twenty_thirteen", default: 0
    t.integer "twenty_fourteen", default: 0
    t.integer "twenty_fifteen", default: 0
    t.integer "twenty_sixteen", default: 0
    t.integer "twenty_seventeen", default: 0
    t.integer "twenty_eighteen", default: 0
    t.integer "twenty_nineteen", default: 0
    t.integer "twenty_twenty", default: 0
    t.integer "twenty_twenty_one", default: 0
    t.integer "twenty_twenty_two", default: 0
    t.integer "twenty_twenty_three", default: 0
    t.integer "twenty_twenty_four", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crime_kidnapping_incidents", force: :cascade do |t|
    t.integer "department_code"
    t.integer "municipality_code"
    t.integer "twenty_ten", default: 0
    t.integer "twenty_eleven", default: 0
    t.integer "twenty_twelve", default: 0
    t.integer "twenty_thirteen", default: 0
    t.integer "twenty_fourteen", default: 0
    t.integer "twenty_fifteen", default: 0
    t.integer "twenty_sixteen", default: 0
    t.integer "twenty_seventeen", default: 0
    t.integer "twenty_eighteen", default: 0
    t.integer "twenty_nineteen", default: 0
    t.integer "twenty_twenty", default: 0
    t.integer "twenty_twenty_one", default: 0
    t.integer "twenty_twenty_two", default: 0
    t.integer "twenty_twenty_three", default: 0
    t.integer "twenty_twenty_four", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crime_motor_cycle_thefts", force: :cascade do |t|
    t.integer "department_code"
    t.integer "municipality_code"
    t.integer "twenty_ten", default: 0
    t.integer "twenty_eleven", default: 0
    t.integer "twenty_twelve", default: 0
    t.integer "twenty_thirteen", default: 0
    t.integer "twenty_fourteen", default: 0
    t.integer "twenty_fifteen", default: 0
    t.integer "twenty_sixteen", default: 0
    t.integer "twenty_seventeen", default: 0
    t.integer "twenty_eighteen", default: 0
    t.integer "twenty_nineteen", default: 0
    t.integer "twenty_twenty", default: 0
    t.integer "twenty_twenty_one", default: 0
    t.integer "twenty_twenty_two", default: 0
    t.integer "twenty_twenty_three", default: 0
    t.integer "twenty_twenty_four", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crime_personal_thefts", force: :cascade do |t|
    t.integer "department_code"
    t.integer "municipality_code"
    t.integer "twenty_ten", default: 0
    t.integer "twenty_eleven", default: 0
    t.integer "twenty_twelve", default: 0
    t.integer "twenty_thirteen", default: 0
    t.integer "twenty_fourteen", default: 0
    t.integer "twenty_fifteen", default: 0
    t.integer "twenty_sixteen", default: 0
    t.integer "twenty_seventeen", default: 0
    t.integer "twenty_eighteen", default: 0
    t.integer "twenty_nineteen", default: 0
    t.integer "twenty_twenty", default: 0
    t.integer "twenty_twenty_one", default: 0
    t.integer "twenty_twenty_two", default: 0
    t.integer "twenty_twenty_three", default: 0
    t.integer "twenty_twenty_four", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crime_residential_burglaries", force: :cascade do |t|
    t.integer "department_code"
    t.integer "municipality_code"
    t.integer "twenty_ten", default: 0
    t.integer "twenty_eleven", default: 0
    t.integer "twenty_twelve", default: 0
    t.integer "twenty_thirteen", default: 0
    t.integer "twenty_fourteen", default: 0
    t.integer "twenty_fifteen", default: 0
    t.integer "twenty_sixteen", default: 0
    t.integer "twenty_seventeen", default: 0
    t.integer "twenty_eighteen", default: 0
    t.integer "twenty_nineteen", default: 0
    t.integer "twenty_twenty", default: 0
    t.integer "twenty_twenty_one", default: 0
    t.integer "twenty_twenty_two", default: 0
    t.integer "twenty_twenty_three", default: 0
    t.integer "twenty_twenty_four", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crime_terrorism_acts", force: :cascade do |t|
    t.integer "department_code"
    t.integer "municipality_code"
    t.integer "twenty_ten", default: 0
    t.integer "twenty_eleven", default: 0
    t.integer "twenty_twelve", default: 0
    t.integer "twenty_thirteen", default: 0
    t.integer "twenty_fourteen", default: 0
    t.integer "twenty_fifteen", default: 0
    t.integer "twenty_sixteen", default: 0
    t.integer "twenty_seventeen", default: 0
    t.integer "twenty_eighteen", default: 0
    t.integer "twenty_nineteen", default: 0
    t.integer "twenty_twenty", default: 0
    t.integer "twenty_twenty_one", default: 0
    t.integer "twenty_twenty_two", default: 0
    t.integer "twenty_twenty_three", default: 0
    t.integer "twenty_twenty_four", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crime_traffic_accident_injuries", force: :cascade do |t|
    t.integer "department_code"
    t.integer "municipality_code"
    t.integer "twenty_ten", default: 0
    t.integer "twenty_eleven", default: 0
    t.integer "twenty_twelve", default: 0
    t.integer "twenty_thirteen", default: 0
    t.integer "twenty_fourteen", default: 0
    t.integer "twenty_fifteen", default: 0
    t.integer "twenty_sixteen", default: 0
    t.integer "twenty_seventeen", default: 0
    t.integer "twenty_eighteen", default: 0
    t.integer "twenty_nineteen", default: 0
    t.integer "twenty_twenty", default: 0
    t.integer "twenty_twenty_one", default: 0
    t.integer "twenty_twenty_two", default: 0
    t.integer "twenty_twenty_three", default: 0
    t.integer "twenty_twenty_four", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crime_vehicle_thefts", force: :cascade do |t|
    t.integer "department_code"
    t.integer "municipality_code"
    t.integer "twenty_ten", default: 0
    t.integer "twenty_eleven", default: 0
    t.integer "twenty_twelve", default: 0
    t.integer "twenty_thirteen", default: 0
    t.integer "twenty_fourteen", default: 0
    t.integer "twenty_fifteen", default: 0
    t.integer "twenty_sixteen", default: 0
    t.integer "twenty_seventeen", default: 0
    t.integer "twenty_eighteen", default: 0
    t.integer "twenty_nineteen", default: 0
    t.integer "twenty_twenty", default: 0
    t.integer "twenty_twenty_one", default: 0
    t.integer "twenty_twenty_two", default: 0
    t.integer "twenty_twenty_three", default: 0
    t.integer "twenty_twenty_four", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crimes", force: :cascade do |t|
    t.string "crime_type"
    t.string "department"
    t.string "municipality"
    t.string "dane_code"
    t.string "weapons_types"
    t.date "incident_date"
    t.string "gender"
    t.string "age_group"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "art_crime"
    t.string "description_behaviour"
    t.integer "municipality_code"
    t.integer "department_code"
    t.string "year"
    t.string "month"
    t.integer "weapon_code"
  end

  create_table "departamentos", force: :cascade do |t|
    t.integer "value"
    t.text "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "edad_falls", force: :cascade do |t|
    t.integer "value"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "etnias", force: :cascade do |t|
    t.integer "value"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fallecidos", force: :cascade do |t|
    t.integer "department_code"
    t.integer "muncipality_code"
    t.integer "unit_info"
    t.integer "household_number"
    t.integer "death_count"
    t.integer "gender_indicator"
    t.integer "death_age"
    t.integer "certificate_availability"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "type_of_record"
  end

  create_table "fundamental_indicators", force: :cascade do |t|
    t.integer "muncipality_code"
    t.integer "department_code"
    t.integer "total_dwellings"
    t.integer "total_occupied_dwellings"
    t.integer "total_house_holds"
    t.integer "total_population"
    t.integer "male_count"
    t.integer "female_count"
    t.integer "children_under_five"
    t.integer "under_fifteen"
    t.integer "over_fifteen"
    t.integer "fifteen_to_twenty_nine"
    t.integer "fifteen_to_sixty_four"
    t.integer "over_sixty_four"
    t.integer "women_with_child_wearing_age"
    t.float "sex_ratio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hogares", force: :cascade do |t|
    t.integer "department_code"
    t.integer "muncipality_code"
    t.integer "unit_info"
    t.integer "household_number"
    t.integer "rooms_count"
    t.integer "bedroom_count"
    t.integer "kitchen_area"
    t.integer "water_source"
    t.integer "death_2017"
    t.integer "people_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "type_of_record"
  end

  create_table "marco_de_georreferenciacions", force: :cascade do |t|
    t.integer "department_code"
    t.integer "muncipality_code"
    t.integer "unit_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "municipios", force: :cascade do |t|
    t.integer "department_code"
    t.integer "muncipality_code"
    t.text "muncipality"
    t.text "department"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "new_crimes", force: :cascade do |t|
    t.string "crime_type"
    t.string "department"
    t.string "municipality"
    t.string "dane_code"
    t.string "weapons_types"
    t.date "incident_date"
    t.string "gender"
    t.string "age_group"
    t.integer "quantity"
    t.string "art_crime"
    t.string "description_behaviour"
    t.integer "municipality_code"
    t.integer "department_code"
    t.integer "year"
    t.integer "month"
    t.integer "weapon_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "new_fallecidos", force: :cascade do |t|
    t.integer "department_code"
    t.integer "muncipality_code"
    t.integer "unit_info"
    t.integer "household_number"
    t.integer "death_count"
    t.integer "gender_indicator"
    t.integer "death_age"
    t.integer "certificate_availability"
    t.integer "type_of_record"
    t.integer "survey_code"
    t.integer "housing_unit"
    t.string "common_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rural_sector"
    t.string "rural_section"
    t.string "populated_center"
    t.string "urban_sector"
    t.string "urban_section"
    t.string "block"
    t.string "dane_code_anm"
    t.index ["common_key"], name: "index_new_fallecidos_on_common_key"
  end

  create_table "new_hogares", force: :cascade do |t|
    t.integer "department_code"
    t.integer "muncipality_code"
    t.integer "unit_info"
    t.integer "household_number"
    t.integer "rooms_count"
    t.integer "bedroom_count"
    t.integer "kitchen_area"
    t.integer "water_source"
    t.integer "death_2017"
    t.integer "people_count"
    t.integer "type_of_record"
    t.integer "survey_code"
    t.integer "housing_unit"
    t.string "common_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rural_sector"
    t.string "rural_section"
    t.string "populated_center"
    t.string "urban_sector"
    t.string "urban_section"
    t.string "block"
    t.string "dane_code_anm"
    t.index ["common_key"], name: "index_new_hogares_on_common_key"
  end

  create_table "new_marco_de_georreferenciacions", force: :cascade do |t|
    t.integer "department_code"
    t.integer "muncipality_code"
    t.integer "unit_info"
    t.string "rural_sector"
    t.string "rural_section"
    t.string "populated_center"
    t.string "urban_sector"
    t.string "urban_section"
    t.string "block"
    t.integer "survey_code"
    t.integer "housing_unit"
    t.string "common_key"
    t.string "dane_code_anm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["common_key"], name: "index_new_marco_de_georreferenciacions_on_common_key"
  end

  create_table "new_personas", force: :cascade do |t|
    t.integer "department_code"
    t.integer "muncipality_code"
    t.integer "unit_info"
    t.integer "household_number"
    t.integer "number_of_person_in_household"
    t.integer "gender"
    t.integer "age_group"
    t.integer "relationship_status"
    t.integer "ethnicicity_status"
    t.integer "indigenous_status"
    t.integer "clan_status"
    t.integer "vitsa_status"
    t.integer "company_status"
    t.integer "language_status"
    t.integer "language_understanding"
    t.integer "another_language"
    t.integer "language_count"
    t.integer "birth_place"
    t.integer "residents_5_year"
    t.integer "residents_12_months"
    t.integer "hospitalization_status"
    t.integer "treatment_status"
    t.integer "health_awareness"
    t.integer "health_quality"
    t.integer "life_difficulty"
    t.integer "literacy_rate"
    t.integer "school_presence"
    t.integer "highest_education"
    t.integer "activity_status"
    t.integer "marital_status"
    t.integer "child_birth"
    t.integer "total_children"
    t.integer "male_children"
    t.integer "female_children"
    t.integer "survival_count"
    t.integer "children_survived"
    t.integer "male_survived"
    t.integer "female_survived"
    t.integer "nonreciding_children"
    t.integer "nonreciding_count"
    t.integer "nonreciding_male"
    t.integer "nonreciding_female"
    t.integer "birth_information"
    t.integer "birth_month"
    t.integer "birth_year"
    t.integer "type_of_record"
    t.integer "survey_code"
    t.integer "housing_unit"
    t.string "common_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rural_sector"
    t.string "rural_section"
    t.string "populated_center"
    t.string "urban_sector"
    t.string "urban_section"
    t.string "block"
    t.string "dane_code_anm"
    t.index ["common_key"], name: "index_new_personas_on_common_key"
  end

  create_table "new_viviendas", force: :cascade do |t|
    t.integer "department_code"
    t.integer "muncipality_code"
    t.integer "unit_info"
    t.boolean "ethnic_territory"
    t.integer "ethnic_territory_type"
    t.integer "ethnic_territory_code"
    t.integer "is_protected_area"
    t.integer "home_usage"
    t.integer "house_type"
    t.integer "houses_occupation"
    t.integer "number_of_homes"
    t.integer "contruction_material"
    t.boolean "electricity_availability"
    t.integer "socioeconomic_status"
    t.boolean "aquaduct_availability"
    t.boolean "sewe_availability"
    t.integer "gas_availability"
    t.integer "garbage_disposability"
    t.integer "disposal_frequency"
    t.boolean "internet_availability"
    t.integer "sanitory_quality"
    t.integer "house_category"
    t.integer "home_availability"
    t.integer "resident_number"
    t.integer "protected_area_code"
    t.integer "type_of_record"
    t.integer "survey_code"
    t.integer "housing_unit"
    t.string "common_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rural_sector"
    t.string "rural_section"
    t.string "populated_center"
    t.string "urban_sector"
    t.string "urban_section"
    t.string "block"
    t.string "dane_code_anm"
    t.index ["common_key"], name: "index_new_viviendas_on_common_key"
  end

  create_table "nro_hogars", force: :cascade do |t|
    t.integer "value"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people_in_homes", force: :cascade do |t|
    t.integer "value"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "personas", force: :cascade do |t|
    t.integer "department_code"
    t.integer "muncipality_code"
    t.integer "unit_info"
    t.integer "household_number"
    t.integer "number_of_person_in_household"
    t.integer "gender"
    t.integer "age_group"
    t.integer "relationship_status"
    t.integer "ethnicicity_status"
    t.integer "indigenous_status"
    t.integer "clan_status"
    t.integer "vitsa_status"
    t.integer "company_status"
    t.integer "language_status"
    t.integer "language_understanding"
    t.integer "another_language"
    t.integer "language_count"
    t.integer "birth_place"
    t.integer "residents_5_year"
    t.integer "residents_12_months"
    t.integer "hospitalization_status"
    t.integer "treatment_status"
    t.integer "health_awareness"
    t.integer "health_quality"
    t.integer "life_difficulty"
    t.integer "literacy_rate"
    t.integer "school_presence"
    t.integer "highest_education"
    t.integer "activity_status"
    t.integer "marital_status"
    t.integer "child_birth"
    t.integer "total_children"
    t.integer "male_children"
    t.integer "female_children"
    t.integer "survival_count"
    t.integer "children_survived"
    t.integer "male_survived"
    t.integer "female_survived"
    t.integer "nonreciding_children"
    t.integer "nonreciding_count"
    t.integer "nonreciding_male"
    t.integer "nonreciding_female"
    t.integer "birth_information"
    t.integer "birth_month"
    t.integer "birth_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "type_of_record"
  end

  create_table "primary_indicators", force: :cascade do |t|
    t.integer "muncipality_code"
    t.integer "department_code"
    t.decimal "average_households"
    t.json "percent_of_dwelling_type", default: {}
    t.decimal "percent_of_water_supply_access"
    t.decimal "percent_of_sewage_access"
    t.decimal "percent_of_electricity_access"
    t.decimal "percent_of_internet_access"
    t.decimal "percent_of_gas_connected"
    t.decimal "percent_of_waste_collection"
    t.decimal "average_house_hold_size"
    t.decimal "percent_of_house_holds"
    t.decimal "percent_of_female_headship"
    t.decimal "masculnity_ratio"
    t.decimal "feminity_ratio"
    t.decimal "demographic_dependency_ratio"
    t.decimal "aging_index"
    t.decimal "youth_index"
    t.decimal "child_woman_ratio"
    t.decimal "population_density"
    t.json "distribution_in_geographic_areas", default: {}
    t.json "population_distribution_by_ethnic_and_cultural", default: {}
    t.json "population_by_place_of_birth", default: {}
    t.decimal "literacy_rate_over_15"
    t.decimal "school_attendance_rate"
    t.decimal "person_with_difficulties"
    t.decimal "economically_active_population"
    t.decimal "umeployment_rate"
    t.decimal "infant_mortality_rate"
    t.decimal "fertility_rate"
    t.decimal "life_expectancy_at_birth"
    t.decimal "housing_tenure_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "temporary_crimes", force: :cascade do |t|
    t.string "crime_type"
    t.string "department"
    t.string "municipality"
    t.string "dane_code"
    t.string "weapons_types"
    t.date "incident_date"
    t.string "gender"
    t.string "age_group"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "department_code"
    t.integer "municipality_code"
  end

  create_table "territorialidad_etnicas", force: :cascade do |t|
    t.integer "value"
    t.text "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "viviendas", force: :cascade do |t|
    t.integer "department_code"
    t.integer "muncipality_code"
    t.integer "unit_info"
    t.boolean "ethnic_territory"
    t.integer "ethnic_territory_type"
    t.integer "ethnic_territory_code"
    t.integer "is_protected_area"
    t.integer "home_usage"
    t.integer "house_type"
    t.integer "houses_occupation"
    t.integer "number_of_homes"
    t.integer "contruction_material"
    t.boolean "electricity_availability"
    t.integer "socioeconomic_status"
    t.boolean "aquaduct_availability"
    t.boolean "sewe_availability"
    t.integer "gas_availability"
    t.integer "garbage_disposability"
    t.integer "disposal_frequency"
    t.boolean "internet_availability"
    t.integer "sanitory_quality"
    t.integer "house_category"
    t.integer "home_availability"
    t.integer "resident_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "protected_area_code"
    t.integer "type_of_record"
  end

  create_table "vivo_anos", force: :cascade do |t|
    t.integer "value"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
