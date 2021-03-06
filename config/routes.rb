Freeride::Application.routes.draw do

  root :to => 'home#index'
  match "/search", :to => 'search#index', :as => :search
  match '/dashboard', :to => 'home#dashboard', :as => :dashboard
  match '/signup', :to => 'users#new', :as => :signup
  match '/myfav', :to => 'favorites#myfav', :as => :myfav
  match '/bikes/reports', :to => 'bikes#reports', :as => :reports
  match '/myproj', :to => 'EabProjects#myproj', :as => :myproj
  match '/myhours', :to => 'VolunteerHoursEntries#myhours', :as => :myhours
  match '/logout', :to => 'sessions#destroy', :as => :logout
  match '/alltransactions', :to => 'transactions#all', :as => :alltransactions
  match '/bikes/printview', :to => 'bikes#printview', :as => :printview 
  match '/admin', :to => 'admin#index', :as => :admin

    
  resources :sessions, :only => [:create, :destroy]
  resources :safety_item_responses
  resources :safety_items, :except => [:show]
  resources :safety_inspections
  resources :volunteer_hours_entries, :except => [:edit]
  resources :repair_hours_entries, :except => [:edit]
  resources :hours_entries, :except => [:create, :destroy, :show, :edit]
  resources :users, :except => [:new]
  resources :eab_projects do
    member do
      put 'sign_off'
    end
  end
  resources :locations
  resources :bike_models
  resources :bike_brands
  resources :bikes
  resources :favorites
  resources :bike_assesments
  resources :transactions, :except => [:show, :edit, :update]
  resources :notes
  resources :location_histories
  
  match '/:id' => 'bikes#show'

  


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
  # match ':controller(/:action(/:id(.:format)))'
end
