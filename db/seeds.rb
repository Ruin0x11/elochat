require "factory_bot"

FactoryBot.define do
  sequence :text do |n|
    "text#{n}"
  end

  sequence :ip_address do |n|
    "192.168.0.#{n}"
  end

  sequence :name do |n|
    "user#{n}"
  end

  sequence :language do |n|
    ["en", "jp"][n % 2]
  end

  factory :chat_message do
    kind { [:chat, :dead, :wish, :marr].sample }
    text
    ip_address
    language
  end

  factory :vote do
    vote_count { rand(0..100) }
    vote_user
    vote_history
  end

  factory :vote_user do
    name
    ip_address
    total_vote_count { rand(0..1000) }
    reset_at { DateTime.now }
  end

  factory :vote_history do
    language
  end
end

if ENV['RACK_ENV'] != "production"
  100.times do
    FactoryBot.create(:chat_message)
  end

  200.times do
    FactoryBot.create(:vote_user)
  end
end

2.times do
  hist = FactoryBot.create(:vote_history)

  VoteUser.all.each do |user|
    FactoryBot.create(:vote, vote_history: hist, vote_user: user)
  end
end
