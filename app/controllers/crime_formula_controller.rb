class CrimeFormulaController < ApplicationController
	 def populate_crime_extorsions
		PopulateCrimeExtorsionsJob.perform_later

		render json: { message: "Crime extorsion data update started. It will run in the background." }
	end
end
