# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_01_08_092242) do

  create_table "cookings", force: :cascade do |t|
    t.integer "meal_id"
    t.string "cooking_name", null: false
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_id"], name: "index_cookings_on_meal_id"
  end

  create_table "flavors", force: :cascade do |t|
    t.integer "post_id"
    t.string "flavor_name", null: false
    t.string "flavor_quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_flavors_on_post_id"
  end

  create_table "foodstuffs", force: :cascade do |t|
    t.integer "post_id"
    t.string "foodstuff_name", null: false
    t.string "foodstuff_quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_foodstuffs_on_post_id"
  end

  create_table "genres", force: :cascade do |t|
    t.integer "user_id"
    t.integer "cooking_id"
    t.string "genre_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cooking_id"], name: "index_genres_on_cooking_id"
    t.index ["user_id"], name: "index_genres_on_user_id"
  end

  create_table "meals", force: :cascade do |t|
    t.integer "user_id"
    t.string "title", null: false
    t.text "meal_description"
    t.date "date", null: false
    t.string "mealtime", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_meals_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "user_id"
    t.string "post_name", null: false
    t.text "post_description"
    t.string "post_image_id", null: false
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.integer "post_id"
    t.text "recipe_description", null: false
    t.string "recipe_image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_recipes_on_post_id"
  end

  create_table "tags", force: :cascade do |t|
    t.integer "genre_id"
    t.integer "cooking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cooking_id"], name: "index_tags_on_cooking_id"
    t.index ["genre_id"], name: "index_tags_on_genre_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "name", null: false
    t.datetime "remember_created_at"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
