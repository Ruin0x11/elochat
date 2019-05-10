class ChatMessage < ActiveRecord::Base
  enum kind: [ :chat, :dead, :wish ]

  before_validation :set_id_for_language

  def self.by_language(lang)
    where(language: lang)
  end

  def self.most_recent(lang)
    by_language(lang).order(id_for_language: :desc).limit(10)
  end

  def self.latest_id(lang)
    (by_language(lang).last&.id_for_language || 0) + 1
  end

  def to_s
    [id_for_language, date_string, kind + text, ip_address].join("%") + "%\n"
  end

  def date_string
    created_at.strftime("%-m/%d(%M)")
  end

  private

  def set_id_for_language
    self.id_for_language = ChatMessage.latest_id(self.language)
  end
end
