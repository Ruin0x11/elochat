class CreateModels < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_messages do |t|
      t.timestamps null: false
      t.integer :kind, null: false, limit: 2
      t.integer :id_for_language, null: false
      t.string :text, null: false
      t.string :ip_address, null: false
      t.string :language, null: false
    end
    add_index :chat_messages, :language

    create_table :vote_users do |t|
      t.timestamps null: false
      t.string :name, null: false
      t.string :ip_address, null: false
      t.integer :total_vote_count, null: false
      t.datetime :reset_at, null: false
    end
    add_index :vote_users, :name, unique: true

    create_table :vote_histories do |t|
      t.timestamps null: false
      t.string :language, null: false
    end
    add_index :vote_histories, :language
  end
end
