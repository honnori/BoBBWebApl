BoBBWebApl::Application.routes.draw do
  get "bobb_req/regist_user"

  get "bobb_req/access_log"

#  get "bobb_req/online_user_list"

#  get "bobb_req/request_battle"

#  get "bobb_req/response_battlereq"

#  get "bobb_req/battle_status"

#  get "bobb_req/enemy_using_card"

#  get "bobb_req/regist_using_card"

#  get "bobb_req/regist_selected_card"

#  get "bobb_req/enemy_selected_card"

#  get "bobb_req/battle_stop"

  post "bobb_req/regist_user"

  post "bobb_req/access_log"

  post "bobb_req/online_user_list"

  post "bobb_req/request_battle"

  post "bobb_req/response_battlereq"

  post "bobb_req/battle_status"

  post "bobb_req/enemy_using_card"

  post "bobb_req/regist_using_card"

  post "bobb_req/regist_selected_card"

  post "bobb_req/enemy_selected_card"

  post "bobb_req/battle_stop"

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
