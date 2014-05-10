Social::Application.routes.draw do
  get "users/:user_id/posts/:id/show", to: "posts#show", as: "show_post"
  delete "users/:user_id", to: "notifications#clear", as: "clear"
  get "posts/down_vote/:id", to: "posts#down_vote", as: "down_vote"
  get "posts/up_vote/:id", to: "posts#up_vote", as: "up_vote"
  post "users/:id", to: "posts#share", as: "share"
  post "comments/create", as: "comments"
  post "messages/create", as: "messages"
  post "posts/create", as: "posts"
  get "users/search", as: "search"
  get "sessions/destroy"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :sessions
  resources :connections
  
  resources :users do
    resources :notifications
    resources :messages
    member do
      get :following, :followers
    end
    resources :posts do
      resources :votes
      resources :comments do
        resources :votes
      end
    end
  end

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
