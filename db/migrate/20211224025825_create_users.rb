class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.decimal :deposit
      t.boolean :is_admin, default: false
      t.boolean :is_permited
      t.string :address
      t.string :phone

      t.timestamps
    end
    add_index :users, :email
  end
end
