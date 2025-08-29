Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Root route (uncomment and modify as needed)
  # root "posts#index"

  # Main resources
  resources :crimes
  resources :municipios

  resources :fundamental_indicators, only: [:create] do
    collection do
      post :calculate_and_insert_data
      post :calculate_all
      post :fetch_fundamental_indicator_data
      post :fetch_fundamental_indicator_data_fast
    end
  end

  resources :primary_indicators do
    get 'fetch_stat', on: :collection
  end

  get 'vivienda_statistics/fetch_stat', to: 'vivienda_statistics#fetch_stat'
  post 'municipio/create_bulk_municipios', to: 'municipios#create_bulk_municipios'
  post 'crimes/bulk_create', to: 'crimes#create_bulk_crimes'

  resources :territorialidad_etnicas
  post 'territorialidad_etnica/create_bulk_territorialidad_etnicas', to: 'territorialidad_etnicas#create_bulk_territorialidad_etnicas'

  resources :departamentos
  post 'departamento/create_bulk_departamentos', to: 'departamentos#create_bulk_departamentos'

  resources :areas_protegidas
  post 'areas_protegida/create_bulk_areas_protegidas', to: 'areas_protegidas#create_bulk_areas_protegidas'

  resources :people_in_homes
  post 'people_in_home/create_bulk_people_in_homes', to: 'people_in_homes#create_bulk_people_in_homes'

  resources :edad_falls
  post 'edad_fall/create_bulk_edad_falls', to: 'edad_falls#create_bulk_edad_falls'

  resources :etnias
  post 'etnia/create_bulk_etnias', to: 'etnias#create_bulk_etnias'

  resources :nro_hogars
  post 'nro_hogar/create_bulk_nro_hogars', to: 'nro_hogars#create_bulk_nro_hogars'

  resources :vivo_anos
  post 'vivo_ano/create_bulk_vivo_anos', to: 'vivo_anos#create_bulk_vivo_anos'

  resources :marco_de_georreferenciacions
  post 'marco_de_georreferenciacion/create_bulk_marco_de_georreferenciacions', to: 'marco_de_georreferenciacions#create_bulk_marco_de_georreferenciacions'

  resources :viviendas
  post 'vivienda/create_bulk_viviendas', to: 'viviendas#create_bulk_viviendas'

  resources :hogares
  post 'hogare/create_bulk_hogares', to: 'hogares#create_bulk_hogares'

  resources :fallecidos
  post 'fallecido/create_bulk_fallecidos', to: 'fallecidos#create_bulk_fallecidos'

  resources :personas
  post 'persona/create_bulk_personas', to: 'personas#create_bulk_personas'
  get 'persona/export_municipality_data_batch', to: 'personas#export_municipality_data_batch'

  post '/crime_formula/populate_crime_extorsions', to: 'crime_formula#populate_crime_extorsions'
  get '/fetch_crime_data', to: 'crimes#fetch_crime_data'
  post '/fetch_new_crime_data', to: 'crimes#fetch_new_crime_data'
  post '/crime_incidence_rate', to: 'crimes#crime_incidence_rate'
  post '/crime_distribution_by_gender', to: 'crimes#crime_distribution_by_gender'
  post '/crime_distribution_by_age_group', to: 'crimes#crime_distribution_by_age_group'
  post '/crime_distribution_by_weapon', to: 'crimes#crime_distribution_by_weapon'

  post 'new_marco_de_georreferenciacion/create_bulk_marco_de_georreferenciacions', to: 'new_marco_de_georreferenciacions#create_bulk_marco_de_georreferenciacions'


  post '/crime_type_stats', to: 'crimes#crime_type_stats'
  post '/crime_type_by_years', to: 'crimes#crime_type_by_years'
  post '/crime_type_by_department', to: 'crimes#crime_type_by_department'
  post '/crime_type_by_months', to: 'crimes#crime_type_by_months'
  post '/crime_type_by_municipalities', to: 'crimes#crime_type_by_municipalities'


end
