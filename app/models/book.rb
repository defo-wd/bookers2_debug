class Book < ApplicationRecord

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def likes_count
     self.favorites.count
  end

  def comments_count
    self.comments.count
  end
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

  def self.search(keyword)
    where("title LIKE ?", "%#{keyword}%")
  end

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
end