class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.text :body, null: false
      t.integer :comments_count, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
