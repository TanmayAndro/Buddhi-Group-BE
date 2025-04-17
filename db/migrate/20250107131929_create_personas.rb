class CreatePersonas < ActiveRecord::Migration[7.1]
  def change
    create_table :personas do |t|

      t.integer :department_code
      t.integer :muncipality_code
      t.integer :unit_info
      t.integer :household_number
      t.integer :number_of_person_in_household
      t.integer :gender
      t.integer :age_group
      t.integer :relationship_status
      t.integer :ethnicicity_status
      t.integer :indigenous_status
      t.integer :clan_status
      t.integer :vitsa_status
      t.integer :company_status
      t.integer :language_status
      t.integer :language_understanding
      t.integer :another_language
      t.integer :language_count
      t.integer :birth_place
      t.integer :residents_5_year
      t.integer :residents_12_months
      t.integer :hospitalization_status
      t.integer :treatment_status
      t.integer :health_awareness
      t.integer :health_quality
      t.integer :life_difficulty
      t.integer :literacy_rate
      t.integer :school_presence
      t.integer :highest_education
      t.integer :activity_status
      t.integer :marital_status
      t.integer :child_birth
      t.integer :total_children
      t.integer :male_children
      t.integer :female_children
      t.integer :survival_count
      t.integer :children_survived
      t.integer :male_survived
      t.integer :female_survived
      t.integer :nonreciding_children
      t.integer :nonreciding_count
      t.integer :nonreciding_male
      t.integer :nonreciding_female
      t.integer :birth_information
      t.integer :birth_month
      t.integer :birth_year
      
      t.timestamps
    end
  end
end
