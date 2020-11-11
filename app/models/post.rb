class Post < ApplicationRecord
    has_rich_text :content
    #バリデーション 
    validates :user_id, {presence: true}
    validates :title, {presence: true}
    validates :genre, {presence: true}
    
    #DB関連
    belongs_to :user
    has_many :comments, foreign_key: "post_id"
    
end
