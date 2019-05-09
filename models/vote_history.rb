class VoteHistory < ActiveRecord::Base
  has_many :votes, dependent: :destroy
  has_many :vote_users, through: :votes

  def self.top_100
    last.votes.order(created_at: :desc).limit(100)
  end
end
