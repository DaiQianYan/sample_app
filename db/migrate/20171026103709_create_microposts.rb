class CreateMicroposts < ActiveRecord::Migration[5.1]
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    # 13.3 The Micropost migration with added index.
    add_index :microposts, [:user_id, :created_at]
  end
end
