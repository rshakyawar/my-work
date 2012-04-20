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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110817125751) do

  create_table "blog_comments", :force => true do |t|
    t.integer  "blog_post_id"
    t.integer  "user_id"
    t.string   "user_ip"
    t.string   "user_agent"
    t.string   "referrer"
    t.string   "name"
    t.string   "site_url"
    t.string   "email"
    t.text     "body"
    t.datetime "created_at"
  end

  add_index "blog_comments", ["blog_post_id"], :name => "index_blog_comments_on_blog_post_id"

  create_table "blog_images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "blog_post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blog_images", ["blog_post_id"], :name => "index_blog_images_on_blog_post_id"

  create_table "blog_posts", :force => true do |t|
    t.string   "title",                           :null => false
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",    :default => false, :null => false
    t.integer  "user_id"
    t.datetime "published_at"
  end

  create_table "blog_tags", :force => true do |t|
    t.integer "blog_post_id"
    t.string  "tag",          :null => false
  end

  add_index "blog_tags", ["blog_post_id"], :name => "index_blog_tags_on_blog_post_id"
  add_index "blog_tags", ["tag"], :name => "index_blog_tags_on_tag"

  create_table "partners", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                     :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "partners", ["confirmation_token"], :name => "index_partners_on_confirmation_token", :unique => true
  add_index "partners", ["email"], :name => "index_partners_on_email", :unique => true
  add_index "partners", ["reset_password_token"], :name => "index_partners_on_reset_password_token", :unique => true

  create_table "products", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_one_file_name"
    t.string   "logo_one_content_type"
    t.integer  "logo_one_file_size"
    t.datetime "logo_one_updated_at"
    t.string   "logo_two_file_name"
    t.string   "logo_two_content_type"
    t.integer  "logo_two_file_size"
    t.datetime "logo_two_updated_at"
    t.string   "top_banner_file_name"
    t.string   "top_banner_content_type"
    t.integer  "top_banner_file_size"
    t.datetime "top_banner_updated_at"
    t.string   "bottom_banner_file_name"
    t.string   "bottom_banner_content_type"
    t.integer  "bottom_banner_file_size"
    t.datetime "bottom_banner_updated_at"
    t.string   "background_file_name"
    t.string   "background_content_type"
    t.integer  "background_file_size"
    t.datetime "background_updated_at"
    t.string   "versus_left_file_name"
    t.string   "versus_left_content_type"
    t.integer  "versus_left_file_size"
    t.datetime "versus_left_updated_at"
    t.string   "versus_right_file_name"
    t.string   "versus_right_content_type"
    t.integer  "versus_right_file_size"
    t.datetime "versus_right_updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "age"
    t.string   "gender"
    t.string   "occupation"
    t.string   "income"
    t.string   "size_waist"
    t.string   "size_inseam"
    t.string   "size_show"
    t.string   "size_shirt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id", :unique => true

  create_table "questions", :force => true do |t|
    t.text     "title"
    t.string   "font_style"
    t.string   "font_color"
    t.integer  "product_id"
    t.integer  "question_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "submitted_assets", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "url"
    t.string   "whatisit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscribers", :force => true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscribers", ["email"], :name => "index_subscribers_on_email"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                     :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
