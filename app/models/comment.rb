class Comment < ApplicationRecord
  #DB関連
  belongs_to :user
  belongs_to :post
end
