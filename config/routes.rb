Pipepost::Application.routes.draw do

  devise_for :users, :controllers => {:registrations => "registrations"}

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'


  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable

  root :to => 'static_pages#home'
  get "static_pages/home",:path=>:home
  get "static_pages/about",:path=>:about
  get "static_pages/blog",:path=>:blog
  get "static_pages/contact",:path=>:contact
  get "static_pages/cart",:path=>:cart
  get "static_pages/subscribe",:path=>:subscribe
  post "transactions/new",:path=>:make_payment
  post "transactions/create_customer"
  get "transactions/all_plan"
  get "transactions/offline_notification"=>"transactions#offline_notification"
  get 'transactions/subregion_options' => 'transactions#subregion_options'
  devise_scope :user do
    get 'sign_up/:plan'=>"registrations#new",:as=>:new_user_registration
  end

  get "/webhooks" do
    challenge = request.params["bt_challenge"]
    challenge_response = Braintree::WebhookNotification.verify(challenge)
    return [200, challenge_response]
  end
  

  resources :products, :path => :store, :only => [:index,:show]



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
