
class NewPersona < ApplicationRecord
	self.table_name = :new_personas


	enum :number_of_person_in_household, { "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "11": 11, "12": 12, "13": 13, "14": 14, "15": 15, "16": 16, "17": 17, "18": 18, "19": 19, "20": 20, "21": 21, "22": 22, "23": 23, "24": 24, "25": 25 }, prefix: :pers_number_of_person_in_household

	enum :gender, { "Man": 1, "Woman": 2 }, prefix: :pers_gender

	enum :age_group, { "de 00 A 04 Años": 1, "de 05 A 09 Años": 2, "de 10 A 14 Años": 3, "de 15 A 19 Años": 4, "de 20 A 24 Años": 5, "de 25 A 29 Años": 6, "de 30 A 34 Años": 7, "de 35 A 39 Años": 8, "de 40 A 44 Años": 9, "de 45 A 49 Años": 10, "de 50 A 54 Años": 11, "de 55 A 59 Años": 12, "de 60 A 64 Años": 13, "de 65 A 69 Años": 14, "de 70 A 74 Años": 15, "de 75 A 79 Años": 16, "de 80 A 84 Años": 17, "de 85 A 89 Años": 18, "de 90 A 94 Años": 19, "de 95 A 99 Años": 20, "de 100 y más Años": 21 }, prefix: :pers_age_group

	enum :relationship_status, { "Head of household": 1, "Couple (Spouse, partner, spouse)": 2, "Son/daughter, Step-son/daughter": 3, "Other Relatives": 4, "Other NON-relatives": 5, "Not Applicable": 6 }, prefix: :pers_relationship_status

	enum :ethnicicity_status, { "Indigenous?": 1, "Gypsy or Rom?": 2, "Raizal of the Archipelago of San Andrés, Providencia and Santa Catalina?": 3, "Palenquero from San Basilio?": 4, "Black, Mulatto, Afro-descendant, Afro-Colombian?": 5, "No ethnic group": 6, "Does not inform": 9 }, prefix: :pers_ethnicicity_status

	enum :clan_status, { "apshana": 1, "epieyu": 2, "ipuana": 3, "jayaliyu": 4, "ji´inu - ji>inu": 5, "jusayu": 6, "paUsayu": 7, "pushaina": 8, "sapuana": 9, "sijona": 10, "uchalayu": 11, "ulewana": 12, "uliana": 13, "uliyu": 14, "uraliyu": 15, "walepushana": 16, "waliriyu": 17, "wouliyu": 18, "epinayu": 19, "kuamaka": 20, "macotama": 21, "surivaca": 22, "ukumeshy": 23, "Not Applicable": 25, "No Clan Information": 99 }, prefix: :pers_clan_status

	enum :vitsa_status, { "Boloc": 1, "Churon": 2, "Mijay": 3, "Ghuso – Ruso": 4, "Greek": 5, "Hanes": 6, "Boyhas – Boyás": 7, "Langosesti": 8, "No visa information": 9, "No Aplica": 10 }, prefix: :pers_vitsa_status

	enum :company_status, { "Bogotá PRORROM": 1, "Bogotá Unión Romaní": 2, "Cúcuta_Norte_De_Santander": 3, "Envigado_Antioquia": 4, "Girón_Santander": 5, "Pasto_Nariño": 6, "Sabanalarga_Atlántico": 7, "Sahagún_Cordoba": 8, "Sampués_Sucre": 9, "Sanpelayo_Cordoba": 10, "Tolima_Tolima": 11, "No Aplica": 13, "Sin Información de Kumpania": 99 }, prefix: :pers_company_status

	enum :language_status, { "YES": 1, "NO": 2, "Not Applicable": 4, "Does not inform": 9 }, prefix: :pers_language_status

	enum :language_understanding, { "YES": 1, "NO": 2, "Not Applicable": 4, "Does not inform": 9 }, prefix: :pers_language_understanding

	enum :another_language, { "YES": 1, "NO": 2, "Not Applicable": 4, "Does not inform": 9 }, prefix: :pers_another_language

	enum :language_count, { "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "No information": 9, "Not applicable": 10 }, prefix: :pers_language_count

	enum :birth_place, { "In this mine": 1, "In another Colombian city": 2, "In another country": 3, "Does not inform": 9, "Not applicable": 10 }, prefix: :pers_birth_place

	enum :residents_5_year, { "I was not born": 1, "In this mine": 2, "In another Colombian city": 3, "In another country": 4, "Not Applicable": 6, "Does not inform": 9 }, prefix: :pers_residents_5_year

	enum :residents_12_months, { "I was not born": 1, "In this mine": 2, "In another Colombian city": 3, "In another country": 4, "Not Applicable": 6, "Does not inform": 9 }, prefix: :pers_residents_12_months

	enum :hospitalization_status, { "YES": 1, "NO": 2, "Does not inform": 9 }, prefix: :pers_hospitalization_status

	enum :treatment_status, { "Did you go to the social health security entity of which you are a member?": 1, "Did you go to a private doctor? (general, specialist, dentist, therapist or other)": 2, "Did you go to an apothecary, pharmacist, druggist?": 3, "Did you attend alternative therapies? (acupuncture, flower essences, music therapies, homeopath, etc.)": 4, "Did you go to an indigenous spiritual authority?": 5, "Did you go to another doctor from an ethnic group? (healer, herbalist, etc.)": 6, "Did you use home remedies?": 7, "self-prescribed": 8, "He didn't do anything": 9, "Does not apply": 11, "Does not inform": 99 }, prefix: :pers_treatment_status
	
	enum :health_awareness, { "YES": 1, "NO": 2, "Not Applicable": 4, "Does not inform": 9 }, prefix: :pers_health_awareness

	enum :health_quality, { "Very good": 1, "Good": 2, "Bad": 3, "Very Bad": 4, "Not Applicable": 6, "Does not inform": 9 }, prefix: :pers_health_quality

	enum :life_difficulty, { "YES": 1, "NO": 2, "Does not inform": 9 }, prefix: :pers_life_difficulty

	enum :literacy_rate, { "YES": 1, "NO": 2, "Not Applicable": 4, "Does not inform": 9 }, prefix: :pers_literacy_rate

	enum :school_presence, { "YES": 1, "NO": 2, "Not Applicable": 4, "Does not inform": 9 }, prefix: :pers_school_presence

	enum :highest_education, { "Preschool": 1, "Primary basic": 2, "Basic high school": 3, "Academic or classical media": 4, "Technical media": 5, "Normalist": 6, "Professional or technological technique": 7, "academic": 8, "Specialization, master's degree, doctorate": 9, "None": 10, "Does not apply": 12, "Does not inform": 99 }, prefix: :pers_highest_education

	enum :activity_status, { "No information": 0, "Did you work for at least one hour in an activity that generated some income?": 1, "Did you work or help in a business for at least one hour without getting paid?": 2, "Did you not work, but did you have a job, job or business from which you receive income?": 3, "Am I looking for work?": 4, "Did you live on retirement, pension or income?": 5, "Study?": 6, "Did you do household chores?": 7, "Are you permanently unable to work?": 8, "Have you been in another situation?": 9, "Not Applicable": 10 }, prefix: :pers_activity_status
	
	enum :marital_status, { "Free Union?": 1, "Married?": 2, "Divorced?": 3, "Separated from a free union?": 4, "Separated from marriage?": 5, "Widowed?": 6, "Single? (You have never been married or lived in a common law union)": 7, "Not Information": 9, "Not Applicable": 10 }, prefix: :pers_marital_status

	enum :child_birth, { "YES": 1, "NO": 2, "Not Applicable": 4, "Does not inform": 9 }, prefix: :pers_child_birth

	enum :total_children, { "1 Son": 1, "2 Sons": 2, "3 Sons": 3, "4 Sons": 4, "5 Sons": 5, "6 Sons": 6, "7 Sons": 7, "8 Sons": 8, "9 Sons": 9, "10 Sons": 10, "11 Son": 11, "12 Sons": 12, "13 Sons": 13, "14 Sons": 14, "15 Sons": 15, "16 Sons": 16, "17 Sons": 17, "18 Sons": 18, "19 Sons": 19, "20 Sons": 20, "21 Sons": 21, "22 Sons": 22, "23 Sons": 23, "24 - Sons": 24, "25 - Sons": 25, "No information": 99, "Not applicable": 100 }, prefix: :pers_total_children

	enum :male_children, { "0 Sons": 0, "1 Son": 1, "2 Sons": 2, "3 Sons": 3, "4 Sons": 4, "5 Sons": 5, "6 Sons": 6, "7 Sons": 7, "8 Sons": 8, "9 Sons": 9, "10 Sons": 10, "11 Son": 11, "12 Sons": 12, "13 Sons": 13, "14 Sons": 14, "15 Sons": 15, "16 Sons": 16, "17 Sons": 17, "18 Sons": 18, "19 Sons": 19, "20 Sons": 20, "21 Sons": 21, "22 Sons": 22, "23 Sons": 23, "24 Sons": 24, "25 Sons": 25, "Not Applicable": 27, "No Information": 99 }, prefix: :pers_male_children

	enum :female_children, { "0 Sons": 0, "1 Son": 1, "2 Sons": 2, "3 Sons": 3, "4 Sons": 4, "5 Sons": 5, "6 Sons": 6, "7 Sons": 7, "8 Sons": 8, "9 Sons": 9, "10 Sons": 10, "11 Son": 11, "12 Sons": 12, "13 Sons": 13, "14 Sons": 14, "15 Sons": 15, "16 Sons": 16, "17 Sons": 17, "18 Sons": 18, "19 Sons": 19, "20 Sons": 20, "21 Sons": 21, "22 Sons": 22, "23 Sons": 23, "24 Sons": 24, "25 Sons": 25, "Not Applicable": 27, "No Information": 99 }, prefix: :pers_female_children

	enum :survival_count, { "How many": 1, "Doesn't Know": 2, "Does not inform": 9, "Not applicable": 10 }, prefix: :pers_survival_count

	enum :children_survived, { "0 Sons": 0, "1 Son": 1, "2 Sons": 2, "3 Sons": 3, "4 Sons": 4, "5 Sons": 5, "6 Sons": 6, "7 Sons": 7, "8 Sons": 8, "9 Sons": 9, "10 Sons": 10, "11 Son": 11, "12 Sons": 12, "13 Sons": 13, "14 Sons": 14, "15 Sons": 15, "16 Sons": 16, "17 Sons": 17, "18 Sons": 18, "19 Sons": 19, "20 Sons": 20, "21 Sons": 21, "22 Sons": 22, "23 Sons": 23, "24 Sons": 24, "25 Sons": 25, "Not Applicable": 27, "No Information": 99 }, prefix: :pers_children_survived

	enum :male_survived, { "0 Sons": 0, "1 Son": 1, "2 Sons": 2, "3 Sons": 3, "4 Sons": 4, "5 Sons": 5, "6 Sons": 6, "7 Sons": 7, "8 Sons": 8, "9 Sons": 9, "10 Sons": 10, "11 Son": 11, "12 Sons": 12, "13 Sons": 13, "14 Sons": 14, "15 Sons": 15, "16 Sons": 16, "17 Sons": 17, "18 Sons": 18, "19 Sons": 19, "20 Sons": 20, "21 Sons": 21, "22 Sons": 22, "23 Sons": 23, "24 Sons": 24, "25 Sons": 25, "Not Applicable": 27, "No Information": 99 }, prefix: :pers_male_survived

	enum :female_survived, { "0 Sons": 0, "1 Son": 1, "2 Sons": 2, "3 Sons": 3, "4 Sons": 4, "5 Sons": 5, "6 Sons": 6, "7 Sons": 7, "8 Sons": 8, "9 Sons": 9, "10 Sons": 10, "11 Son": 11, "12 Sons": 12, "13 Sons": 13, "14 Sons": 14, "15 Sons": 15, "16 Sons": 16, "17 Sons": 17, "18 Sons": 18, "19 Sons": 19, "20 Sons": 20, "21 Sons": 21, "22 Sons": 22, "23 Sons": 23, "24 Sons": 24, "25 Sons": 25, "Not Applicable": 27, "No Information": 99 }, prefix: :pers_female_survived

	enum :nonreciding_children, { "How many": 1, "Doesn't Know": 2, "Not Applicable": 4, "Does not inform": 9 }, prefix: :pers_nonreciding_children

	enum :nonreciding_count, { "0 Sons": 0, "1 Son": 1, "2 Sons": 2, "3 Sons": 3, "4 Sons": 4, "5 Sons": 5, "6 Sons": 6, "7 Sons": 7, "8 Sons": 8, "9 Sons": 9, "10 Sons": 10, "11 Son": 11, "12 Sons": 12, "13 Sons": 13, "14 Sons": 14, "15 Sons": 15, "16 Sons": 16, "17 Sons": 17, "18 Sons": 18, "19 Sons": 19, "20 Sons": 20, "21 Sons": 21, "22 Sons": 22, "23 Sons": 23, "24 Sons": 24, "25 Sons": 25, "Not Applicable": 27, "No Information": 99 }, prefix: :pers_nonreciding_count

	enum :nonreciding_male, { "0 Sons": 0, "1 Son": 1, "2 Sons": 2, "3 Sons": 3, "4 Sons": 4, "5 Sons": 5, "6 Sons": 6, "7 Sons": 7, "8 Sons": 8, "9 Sons": 9, "10 Sons": 10, "11 Son": 11, "12 Sons": 12, "13 Sons": 13, "14 Sons": 14, "15 Sons": 15, "16 Sons": 16, "17 Sons": 17, "18 Sons": 18, "19 Sons": 19, "20 Sons": 20, "21 Sons": 21, "22 Sons": 22, "23 Sons": 23, "24 Sons": 24, "25 Sons": 25, "Not Applicable": 27, "No Information": 99 }, prefix: :pers_nonreciding_male

	enum :nonreciding_female, { "0 Sons": 0, "1 Son": 1, "2 Sons": 2, "3 Sons": 3, "4 Sons": 4, "5 Sons": 5, "6 Sons": 6, "7 Sons": 7, "8 Sons": 8, "9 Sons": 9, "10 Sons": 10, "11 Son": 11, "12 Sons": 12, "13 Sons": 13, "14 Sons": 14, "15 Sons": 15, "16 Sons": 16, "17 Sons": 17, "18 Sons": 18, "19 Sons": 19, "20 Sons": 20, "21 Sons": 21, "22 Sons": 22, "23 Sons": 23, "24 Sons": 24, "25 Sons": 25, "Not Applicable": 27, "No Information": 99 }, prefix: :pers_nonreciding_female

	enum :birth_information, { "Yes, month and year": 1, "Doesn't Know": 2, "Does not report": 9, "Not applicable": 10 }, prefix: :pers_birth_information

	enum :birth_month, { "January": 1, "February": 2, "March": 3, "April": 4, "May": 5, "June": 6, "July": 7, "August": 8, "September": 9, "October": 10, "November": 11, "December": 12, "No Information": 99, "Not Applicable": 100 }, prefix: :pers_birth_month

end