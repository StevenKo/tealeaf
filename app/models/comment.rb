class Comment < ActiveRecord::Base
  include VoteableKoSteven
  belongs_to :user
  belongs_to :post

  validates :body, presence: true
end
