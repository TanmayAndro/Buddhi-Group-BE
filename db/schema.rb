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

ActiveRecord::Schema[7.1].define(version: 2025_01_08_122019) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas_protegidas", force: :cascade do |t|
    t.integer "value"
    t.text "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
  end

  create_table "vivo_anos", force: :cascade do |t|
    t.integer "value"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
