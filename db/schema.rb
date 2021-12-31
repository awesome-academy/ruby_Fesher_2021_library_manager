# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_24_034854) do

  create_table "authors", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "books", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 10
    t.string "description"
    t.integer "number_of_page"
    t.integer "quantity"
    t.bigint "author_id"
    t.bigint "publisher_id"
    t.bigint "category_id"
    t.integer "rate_score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_books_on_author_id"
    t.index ["category_id"], name: "index_books_on_category_id"
    t.index ["publisher_id"], name: "index_books_on_publisher_id"
    t.index ["rate_score"], name: "index_books_on_rate_score"
  end

  create_table "categories", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "commentable_type"
    t.integer "commentable_id"
    t.bigint "user_id", null: false
    t.string "content"
    t.integer "rate_score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
    t.index ["commentable_id", "created_at"], name: "index_comments_on_commentable_id_and_created_at"
    t.index ["commentable_id"], name: "index_comments_on_commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "follows", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "followable_type"
    t.integer "followable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followable_id", "followable_type"], name: "index_follows_on_followable_id_and_followable_type"
    t.index ["followable_id"], name: "index_follows_on_followable_id"
    t.index ["user_id", "followable_id"], name: "index_follows_on_user_id_and_followable_id", unique: true
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "likes", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "likeable_type"
    t.integer "likeable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["likeable_id", "likeable_type"], name: "index_likes_on_likeable_id_and_likeable_type"
    t.index ["likeable_id"], name: "index_likes_on_likeable_id"
    t.index ["user_id", "likeable_id"], name: "index_likes_on_user_id_and_likeable_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "publishers", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "desscription"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "requests", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "book_id", null: false
    t.timestamp "begin_day"
    t.timestamp "end_day"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_requests_on_book_id"
    t.index ["created_at"], name: "index_requests_on_created_at"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.decimal "deposit", precision: 10
    t.boolean "is_admin", default: false
    t.boolean "is_permited"
    t.string "address"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "books", "authors"
  add_foreign_key "books", "categories"
  add_foreign_key "books", "publishers"
  add_foreign_key "comments", "users"
  add_foreign_key "follows", "users"
  add_foreign_key "likes", "users"
  add_foreign_key "requests", "books"
  add_foreign_key "requests", "users"
end
