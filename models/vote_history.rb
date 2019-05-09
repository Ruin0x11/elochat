class VoteHistory < ActiveRecord::Base
  has_many :votes, dependent: :destroy
  has_many :vote_users, through: :votes

  def self.vote(language)
    votes = where(language: language).last.votes.order(created_at: :desc).limit(100)

    resp = ""
    votes.each_with_index do |vote, i|
      resp << (i + 1).to_s << "<>" << vote.to_s
    end
    resp
  end
end
