class Vote < ActiveRecord::Base
  belongs_to :vote_user
  belongs_to :vote_history

  delegate :name, :ip_address, to: :vote_user

  def to_s
    [name, vote_count, ip_address, vote_user.metadata].join("<>") + "<>\n"
  end
end
