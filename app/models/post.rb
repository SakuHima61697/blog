class Post < ApplicationRecord
    has_rich_text :content
    validates :user_id, {presence: true}
    validates :title, {presence: true}
    validates :genre, {presence: true}
    belongs_to :user
end
