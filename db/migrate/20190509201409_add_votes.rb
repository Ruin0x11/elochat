class AddVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.timestamps null: false
      t.integer :vote_count, null: false
      t.references :vote_user, foreign_key: true
      t.references :vote_history, foreign_key: true
    end
  end
end
