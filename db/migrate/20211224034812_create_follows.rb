class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.references :user, null: false, foreign_key: true
      t.string :followable_type
      t.integer :followable_id

      t.timestamps
    end
    add_index :follows, :followable_id
    add_index :follows, [:user_id, :followable_id], unique: true
    add_index :follows, [:followable_id, :followable_type]
  end
end
