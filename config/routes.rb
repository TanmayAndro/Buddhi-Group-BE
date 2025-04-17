Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :municipios
  post 'municipio/create_bulk_municipios', to: 'municipios#create_bulk_municipios'

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


end
