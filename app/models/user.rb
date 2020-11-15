class User < ApplicationRecord
    has_secure_password
    #プロフィール画像設定
    mount_uploader :image, ImageUploader
    #バリデーション 
    validates :name, {presence: true, exclusion: { in: %w(管理者) }}
    validates :email, {presence: true, uniqueness: true}
    validates :password, {presence: true}
    
    #DB関連
    has_many :posts, foreign_key: "user_id"
    has_many :comments, foreign_key: "user_id"
    
end
