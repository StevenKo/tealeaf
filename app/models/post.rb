class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: :user_id, class_name: "User" 
  has_many :comments

  has_many :post_category_relations
  has_many :categories, through: :post_category_relations
  has_many :votes, as: :voteable

  validates :title, presence: true

  def total_votes
    self.votes.where(vote: true).size - self.votes.where(vote: false).size
  end
end