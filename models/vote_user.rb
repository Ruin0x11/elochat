class VoteUser < ActiveRecord::Base
  has_many :votes
  has_many :vote_histories, through: :votes

  def rank
    100
  end

  def total_vote_count_query
    Vote.where(vote_user_id: id).sum { |v| v.vote_count }
  end

  def metadata
    [reset_at.to_i, total_vote_count_query, rank].join("#") + "#"
  end
end
