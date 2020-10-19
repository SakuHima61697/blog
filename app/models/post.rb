class Post < ApplicationRecord
    has_rich_text :content
    validates :user_id, {presence: true}
    
    def user
       return User.find_by(id: self.user_id) 
    end
end
