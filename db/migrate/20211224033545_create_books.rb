 class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name
      t.decimal :price
      t.string :description
      t.integer :number_of_page
      t.integer :quantity
      t.references :author, null: true, foreign_key: true
      t.references :publisher, null: true, foreign_key: true
      t.references :category, null: true, foreign_key: true
      t.integer :rate_score

      t.timestamps
    end
    add_index :books, :rate_score
  end
end
