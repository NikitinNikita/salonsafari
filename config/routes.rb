Salonsafari::Application.routes.draw do
  resources :photos
  get 'add_photo_to_folder' => 'photos#add_photo_to_folder'
  post 'add_photo_to_folder_post' => 'photos#add_photo_to_folder_post'

  get 'delete_photo_from_folder' => 'photos#delete_photo_from_folder'
  get 'delete_photo_from_folder_post' => 'photos#delete_photo_from_folder_post'

  get "welcome/index"
  get "about" => "welcome/about"
  get "service/affro" => "welcome#affro"
  get "service/chemicalperm" => "welcome#chemicalperm"
  get "contacts" => "welcome#contacts"
  get "gallery" => "welcome#gallery"
  get "service/haircare" => "welcome#haircare"
  get "service/haircoloring" => "welcome#haircoloring"
  get "service/haircut" => "welcome#haircut"
  get "service/hairextension" => "welcome#hairextension"
  get "service/hairstyling" => "welcome#hairstyling"
  get "service/makeup" => "welcome#makeup"
  get "service/manicure" => "welcome#manicure"
  get "service" => "welcome#service"
  #get "admin/index"
  #get "sessions/new"
  #get "sessions/create"
  #get "sessions/destroy"
  resources :users

  resources :comments
  
  resources :vacancies

  resources :sales

  resources :news

  get 'admin' => 'admin#index'
  get 'admin/index_post'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'welcome#index', as: 'index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
