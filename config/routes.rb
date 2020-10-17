Rails.application.routes.draw do
  

  get 'blog/login' =>"user#login"
  get 'blog/index'
  get 'blog/create'
  get 'blog/show'
  get 'blog/update'
  get 'blog/delete'
  
  post "blog/login" => "user#login"
  
  get  'blog/signup' => "user#new"
  post "blog/signup" => "user#create"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
