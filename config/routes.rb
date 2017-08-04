Rails.application.routes.draw do
  get 'providers/new'

  get 'providers/create'

  get 'providers/failure'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'punk/index'


 get 'park/home'


   get 'punk/select' => 'punk#select_punk', :as => :select_punk


      post 'punk/login_guest' => 'punk#login_guest', :as => :login_guest


   post 'punk/auth_into_eth_address' => 'punk#auth_into_eth_address'

   post 'punk/login' => 'punk#login_punk', :as => :login_punk

   get 'punk/logout' => 'punk#logout_punk', :as => :logout_punk

   get 'logout' => 'punk#logout_address', :as => :logout_address

   get 'punk/:punk_id' => 'punk#show', :as =>:punk


      get 'punk/:punk_id/edit' => 'punk#edit', :as =>:edit_punk


      #get   '/login', :to => 'sessions#new', :as => :login
      match '/auth/:provider/callback', :to => 'providers#create'
      match '/auth/failure', :to => 'providers#failure'

 # The priority is based upon order of creation: first created -> highest priority.
 # See how all your routes lay out with "rake routes".

 # You can have the root of your site routed with "root"
 root 'park#root'

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
