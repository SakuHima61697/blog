Rails.application.routes.draw do
  
  root  'blog#index'
  
  get 'blogs' => "blog#index"
  
  get 'blogs/new' => "blog#new"
  post "blogs/new" => "blog#create"
  
  get "blogs/update/:id" => "blog#update"
  post "blogs/update/:id" => "blog#edit"
  
  get "blogs/delete/:id" => "blog#delete"
  post "blogs/delete/:id" => "blog#destroy"
  
  get 'blogs/show/:id' => "blog#show"
  
  get 'blogs/update'
  get 'blogs/delete'
  
  get 'blogs/login' => "user#login_form"
  post "blogs/login" => "user#login"
  
  get  'blogs/signup' => "user#new"
  post "blogs/signup" => "user#create"
  
  get "blogs/users" => "user#index"

  get "blogs/user/:id" => "user#show"
  
  post "user/logout" => "user#logout"
  
  get "blogs/user/edit/:id" => "user#edit"
  post "blogs/user/edit/:id" => "user#update"
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  

end