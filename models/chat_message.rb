class ChatMessage < ActiveRecord::Base
  enum kind: [ :chat, :dead, :wish ]

  def self.most_recent
    order(id: :desc).limit(10)
  end

  def self.latest_id
    (last&.id || 0) + 1
  end

  def to_s
    [id, date_string, kind + text, ip_address].join("%") + "%\n"
  end

  def date_string
    created_at.strftime("%-m/%d(%M)")
  end
end
