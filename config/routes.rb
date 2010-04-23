ActionController::Routing::Routes.draw do |map|
  map.root :controller => :main
  map.signin '/main/signin', :controller => :main, :action => :signin

  map.resources :users
  map.resources :messages do |message|
      message.resources :comments
  end
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
