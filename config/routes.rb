Rails.application.routes.draw do
  
  #ブログサイトトップ
  root  'blog#index'
  
  #ブログ一覧ページ
  get 'blogs' => "blog#index"
  
  #ブログ作成ページ
  get 'blogs/new' => "blog#new"
  post "blogs/new" => "blog#create"
  
  #ブログ編集ページ
  get "blogs/update/:id" => "blog#update"
  post "blogs/update/:id" => "blog#edit"
  
  #ブログ削除ページ
  get "blogs/delete/:id" => "blog#delete"
  post "blogs/delete/:id" => "blog#destroy"
  
  #ブログ詳細ページ
  get 'blogs/show/:id' => "blog#show"
  
  #ブログ詳細ページ(コメント入力)
  post "blogs/show/:id" => "blog#newComment"
  
  #コメント削除
  post "blogs/delete_comment" => "blog#deleteComment"

  #ログインページ
  get 'blogs/login' => "user#login_form"
  post "blogs/login" => "user#login"
  
  #サインアップページ
  get  'blogs/signup' => "user#new"
  post "blogs/signup" => "user#create"
  
  #ユーザー一覧ページ
  get "blogs/users" => "user#index"

  #ユーザー詳細ページ
  get "blogs/user/:id" => "user#show"
  
  #ログアウト
  post "user/logout" => "user#logout"
  
  #ユーザー編集ページ
  get "blogs/user/edit/:id" => "user#edit"
  post "blogs/user/edit/:id" => "user#update"
  
  #ユーザー削除ページ
  get "blogs/user/delete/:id" => "user#delete"
  post "blogs/user/delete/:id" => "user#destroy"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  #管理者権限-----------------------------------
  namespace :admin do
    #管理者ログイン
    get "/login" => "users#login_form"
    post "/login" => "users#login"
  
    #管理者ログアウト
    post "/logout" => "users#logout"
  
    #管理者一覧
    get "/index" => "users#index"
  
    #ユーザー削除
    get "/users/delete/:id" => "users#delete"
    
    #ユーザー削除処理
    post "/users/destroy/:id" => "users#destroy"
    
    #ブログ一覧
    get "/blogs"  => "blogs#index"
    #ブログ削除処理
    post "/blogs/destroy/:id" => "blogs#destroy"
  end

end