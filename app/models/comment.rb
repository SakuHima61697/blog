class Comment < ApplicationRecord
  #バリデーション
  validates :content, {presence: true}
  #DB関連
  belongs_to :user
  belongs_to :post
end
