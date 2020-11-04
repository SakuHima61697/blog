class User < ApplicationRecord
    has_secure_password
    mount_uploader :image, ImageUploader
    validates :name, {presence: true, exclusion: { in: %w(管理者) }}
    validates :email, {presence: true, uniqueness: true}
    validates :password, {presence: true}
    
    has_many :posts, foreign_key: "user_id"
    
    default_value_for :name, "(no name)"
    
    
end
