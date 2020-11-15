# youchika41781/blog
 
会員制ブログ投稿サイト
 
気軽にブログを投稿しやすい会員制サイト
 
 
# Features
 
・サインアップ、ログイン、ユーザー編集・削除などの基本的なユーザー機能
・ブログ投稿・編集・削除機能
・ユーザー一覧、ブログ一覧機能
・ブログに対するコメント投稿機能
・ユーザー・ブログの削除機能(管理者権限)


# Requirement
 
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bcrypt'

gem 'image_processing', '~> 1.2'

gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'mysql2', '>= 0.4.4'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'bootstrap'
gem 'jquery-rails'
gem 'rails-i18n'
gem 'carrierwave'
gem 'coffee-rails', '~> 5.0'
gem 'mini_magick'
gem 'kaminari'
gem 'default_value_for'
gem 'ransack'
gem 'rubocop'
gem 'rubocop-rails'
gem 'fog-aws'
gem 'pry-rails'
gem "aws-sdk-s3", require: false

group :production do
  gem 'pg'
end* hogehuga 1.0.2
 
 
# Installation
 
bundle install


# Note
 
※ユーザー削除時に、ユーザーに紐づいたブログが全て削除される
 
# Author
 
* youchika41781