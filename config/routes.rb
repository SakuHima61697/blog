Rails.application.routes.draw do
  
  get 'blog/index'
  get 'blog/create'
  get 'blog/show'
  get 'blog/update'
  get 'blog/delete'
  
  get 'blog/login' => "user#login"
  post "blog/login" => "user#login"
  
  get  'blog/signup' => "user#new"
  post "blog/signup" => "user#create"
  
  get "blog/user/:id" => "user#show"
  
  post "user/logout" => "user#logout"
  
  get "blog/user/edit/:id" => "user#edit"
  post "blog/user/edit/:id" => "user#update"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
