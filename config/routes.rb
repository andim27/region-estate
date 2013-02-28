Estate::Application.routes.draw do
  resources :ext_codes


  resources :dop_params

  resources :have_fields

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  match 'haves/uploadify' => 'haves#uploadify', :via=>[:post,:put]

  resources :streets
  resources :info_sources
  resources :dop_params
  resources :info_types
  resources :rayons
  resources :zayavkas
  resources :haves
  resources :wants
  resources :wish_lists
  resources :HaveFields
  resources :info_parser_rules
  resources :ext_codes

  match 'info_sources/get_parsed_list',:via => :post
  match 'info_parser_rules/get_parsed_rules',:via => :post
  match 'info_parser_rules/parse_resource',:via => :post
  match 'ext_codes/get_ext_codes',:via => :post
  match 'ext_codes/save_code',:via => :post

  match 'contacts/checktel/',:via => :post
  match 'haves/planirovki/:id' => 'haves#planirovki', :via=>[:get] ##:constraints => {:id => /^\d/}

  #map.connect 'static/:path', :controller => 'static', :action => 'show'
  match  'admin/static/dop_params', :controller => 'static', :action => 'index'
  #match 'zayavkas' => 'zayavkas#create', :via => :put
  match 'streets/inrayon/:id' => 'streets#inrayon'
  #match 'admin/rayons_geo/:action' => 'admin/rayons_geo', :action => /w+/

  match 'admin/rayons_geo/create_poly' => 'admin/rayons_geo#create_poly'
  match 'admin/rayons_geo/save_poly' => 'admin/rayons_geo#save_poly'
  match 'admin/rayons_geo/load_poly' => 'admin/rayons_geo#load_poly'
  match 'admin/rayons_geo/load_streets' => 'admin/rayons_geo#load_streets'
  match 'admin/rayons_geo/save_streets' => 'admin/rayons_geo#save_streets'

  match 'admin/rayons_geo/load_rayons_poly' => 'admin/rayons_geo#load_rayons_poly'
  match 'admin/get_geo_streets/get_streets' => 'admin/get_geo_streets#get_streets'
  match 'admin/get_geo_streets/save_streets' => 'admin/get_geo_streets#save_streets'

  ##match 'admin/streets/:id/rayonname' =>'admin/streets#index'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  match 'translate' => 'translate#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

