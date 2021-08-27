class CreateAuthentications < ActiveRecord::Migration[6.1]
  def change
    create_table :authentications do |t|
      t.string :uid
      t.string :provider
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :authentications, [:user_id, :provider], unique: true
  end
end
