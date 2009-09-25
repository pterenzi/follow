ActionController::Routing::Routes.draw do |map|

  map.resources :user_groups, :collection=>{:manage_users=>:get, :insert_user=>:get,
        :retrieve_users=>:get, :remove_user=>:get}
  
  map.resources :events, :collection=>{:new_event=>:get, :display_calendar=>:get}

  map.resources :items

  map.resources :companies 
  
  map.resources :projects, :collection => {:insert_user => :get, 
      :remove_user=>:get}

  map.resources :pattern_pauses
   
   map.logout "logout", :controller=>"user_sessions", :action=>"destroy"
  # map.resources :account, :controller => "users"
   map.resources :users, :member=>{:change_password=>:get} , :collection=>{:retrieve_users=>:get}
   map.resources :user_sessions
 
  map.resources :comments

  map.resources :messages, :collection => {:mark_as_readed => :get,:search=>:get}

  map.resources :tasks, :collection => {:show_export => :get, :pauser=>:get, :reiniciar_a_task=>:get, 
         :pauser_pattern=>:get, :reiniciar_pattern=>:get, :encaminhar=>:get, :change_alert=>:get,
         :encerrar_task=>:get, :avaliar_task=>:get, :recusar_task=>:get, :reencaminhar_task_refused=>:get,
         :verify_updates=>:get, :verify_new_tasks=>:get, :search=>:get  }
  
  map.resources :tasks do |tasks|
       tasks.resources :comments
    end 

  map.change_language "change_language", :controller=>"languages", :action=>"change_language"

  map.resources :evaluations
  
  map.resources :categories, :collection => {:show_export => :get}

  map.root :controller => "tasks"

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
