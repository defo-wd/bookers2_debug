class Book < ApplicationRecord

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def likes_count
     self.favorites.count
  end
  
  def comments_count
    self.comments.count
  end


  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
end