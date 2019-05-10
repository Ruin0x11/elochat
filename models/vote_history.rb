class VoteHistory < ActiveRecord::Base
  has_many :votes, dependent: :destroy
  has_many :vote_users, through: :votes

  def self.current(lang)
    where(language: lang).last
  end

  def self.current_votes(lang)
    current(lang).votes.order(created_at: :desc).limit(100)
  end

  def find_vote(lang, id)
    # NOTE: The order of the votes can change between sending the
    # registrant list and submitting a vote. If we record the IP of
    # each request then the sent list indices can be cached by IP.
    VoteHistory.current_votes(lang)[id]
  end
end
