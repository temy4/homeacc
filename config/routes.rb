Rails.application.routes.draw do
  get 'data_import/import_csv'
  post 'data_import/upload'

  #devise_for :users
  get 'persons/profile'

  resources :categories_groups
  resources :cards
  resources :money_units
  resources :unit_categories
  resources :taxes
  resources :exchange_rates
  resources :counterparties

  # custom routes
  # GET routes
  get 'welcome/index'
  get 'counterparties/:id/recover' => 'counterparties#recover'
  get 'cards/:id/recover' => 'cards#recover'
  get 'taxes/:id/recover' => 'taxes#recover'
  get 'unit_categories/:id/recover' => 'unit_categories#recover'
  get 'categories_groups/:id/recover' => 'categories_groups#recover'

  get 'currencies' => 'currencies#index'
  get 'currencies/update_all' => 'currencies#update_all'

  get 'money_units/new/in' => 'money_units#money_in'
  get 'money_units/new/out' => 'money_units#money_out'
  get 'money_units/get/:date_from/:date_to' => 'money_units#get_cf_data'
  get 'unit_categories/getinfo/:id' =>'unit_categories#get_refernces'
  # POST routes

  # PUT routes

  # DELETE routes
  resources :counterparties do
    collection do
      post 'destroy_multiple'
    end
  end

  resources :cards do
    collection do
      post 'destroy_multiple'
    end
  end

  resources :taxes do
    collection do
      post 'destroy_multiple'
    end
  end

  resources :unit_categories do
    collection do
      post 'destroy_multiple'
    end
  end

  resources :money_units do
    collection do
      post 'destroy_multiple'

    end
  end

  resources :categories_groups do
    collection do
      post 'destroy_multiple'
    end
  end

  devise_for :users, controllers: { sessions: "users/sessions" }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  #get 'persons/profile', as: 'user_root'

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
