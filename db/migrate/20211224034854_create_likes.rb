class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :likeable_type
      t.integer :likeable_id

      t.timestamps
    end
    add_index :likes, :likeable_id
    add_index :likes, [:user_id, :likeable_id], unique: true
    add_index :likes, [:likeable_id, :likeable_type]
  end
end
