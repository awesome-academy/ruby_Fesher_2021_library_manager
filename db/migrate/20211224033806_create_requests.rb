class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.timestamp :begin_day
      t.timestamp :end_day
      t.integer :status, default: 0

      t.timestamps
    end
    add_index :requests, :created_at
  end
end
