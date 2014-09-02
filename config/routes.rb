Social::Application.routes.draw do
  root 'welcome#index'
  
  get "users/:user_id/posts/:id/show", to: "posts#show", as: "show_post"
  
  get "comments/down_vote/:id", to: "comments#down_vote", as: "down_vote_comment"
  
  get "comments/up_vote/:id", to: "comments#up_vote", as: "up_vote_comment"
  
  get "posts/down_vote/:id", to: "posts#down_vote", as: "down_vote_post"
  
  get "posts/up_vote/:id", to: "posts#up_vote", as: "up_vote_post"
  
  get "proposals/up_vote/:id", to: "proposals#up_vote", as: "up_vote_proposal"
  
  get "proposals/down_vote/:id", to: "proposals#down_vote", as: "down_vote_proposal"
  
  delete "users/:user_id", to: "notifications#clear", as: "clear"
  
  get "groups/groups_joined/:id", to: "groups#groups_joined", as: "groups_joined"
  
  delete "members/leave/:id", to: "members#destroy", as: "leave_group"
  
  post "members/join/:id", to: "members#create", as: "join_group"
  
  get "members/request_to_join/:id", to: "members#request_to_join", as: "request_to_join"
  
  post "posts/share/:id", to: "posts#share", as: "share"
  
  delete "connections/destroy/:id", to: "connections#destroy", as: "unfollow"
  
  post "connections/create/:id", to: "connections#create", as: "follow"
  
  get "search/search/:query", to: "search#search", as: "tagged"
  
  post "hashtags/follow/:id", to: "hashtags#follow", as: "follow_tag"
  
  get "posts/new_comment/:id", to: "posts#new_comment", as: "new_comment_ajax"
  
  get "groups/:group_id/proposals/menu", to: "proposals#menu", as: "proposal_menu"
  
  post "folders/create", as: "create_folder"
  
  post "proposals/create", as: "proposals"
  
  post "comments/create", as: "comments"
  
  post "messages/create", as: "messages"
  
  post "posts/create", as: "posts"
  
  get "search/search", as: "search"
  
  get "pages/older", as: "older"
  
  get "pages/newer", as: "newer"
  
  get "sessions/destroy"
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  
  resources :sessions
  resources :connections
  resources :achievements
  
  resources :folders do
    resources :messages
  end
  
  resources :groups do
    resources :members
    resources :code_modules
    resources :proposals do
      resources :comments
    end
  end
  
  resources :users do
    resources :notifications
    member do
      get :following, :followers
    end
    resources :posts do 
      resources :comments
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
