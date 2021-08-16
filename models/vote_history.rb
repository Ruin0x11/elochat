class VoteHistory < ActiveRecord::Base
  has_many :votes, dependent: :destroy
  has_many :vote_users, through: :votes

  def self.current(lang)
    where(language: lang).order(created_at: :desc).first
  end

  def self.current_votes(lang)
    current(lang).votes.order(created_at: :desc).limit(100)
  end

  def self.find_vote(lang, vote_id)
    VoteHistory.current(lang).votes.where(id: vote_id).first
  end

  def self.new_vote
    [:en, :jp].each do |lang|
      VoteHistory.create(language: lang)
    end
  end
end
