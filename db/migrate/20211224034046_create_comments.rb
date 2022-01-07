class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :commentable_type
      t.integer :commentable_id
      t.references :user, null: false, foreign_key: true
      t.string :content
      t.integer :rate_score, default: 0

      t.timestamps
    end
    add_index :comments, [:commentable_id, :created_at]
    add_index :comments, [:commentable_id, :commentable_type]
    add_index :comments, :commentable_id
    #Ex:- add_index("admin_users", "username")
  end
end
