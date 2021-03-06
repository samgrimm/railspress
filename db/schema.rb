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

ActiveRecord::Schema.define(version: 20_170_320_200_952) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'blogs', force: :cascade do |t|
    t.integer  'website_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['website_id'], name: 'index_blogs_on_website_id', using: :btree
  end

  create_table 'color_combos', force: :cascade do |t|
    t.string   'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'friendly_id_slugs', force: :cascade do |t|
    t.string   'slug',                      null: false
    t.integer  'sluggable_id',              null: false
    t.string   'sluggable_type', limit: 50
    t.string   'scope'
    t.datetime 'created_at'
    t.index %w(slug sluggable_type scope), name: 'index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope', unique: true, using: :btree
    t.index %w(slug sluggable_type), name: 'index_friendly_id_slugs_on_slug_and_sluggable_type', using: :btree
    t.index ['sluggable_id'], name: 'index_friendly_id_slugs_on_sluggable_id', using: :btree
    t.index ['sluggable_type'], name: 'index_friendly_id_slugs_on_sluggable_type', using: :btree
  end

  create_table 'layouts', force: :cascade do |t|
    t.string   'name'
    t.text     'document'
    t.text     'sheet'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string   'image'
  end

  create_table 'links', force: :cascade do |t|
    t.integer  'navbar_id'
    t.integer  'page_id'
    t.string   'display_name'
    t.datetime 'created_at',   null: false
    t.datetime 'updated_at',   null: false
    t.index ['navbar_id'], name: 'index_links_on_navbar_id', using: :btree
    t.index ['page_id'], name: 'index_links_on_page_id', using: :btree
  end

  create_table 'nav_styles', force: :cascade do |t|
    t.string   'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'navbars', force: :cascade do |t|
    t.string   'title'
    t.string   'style'
    t.integer  'website_id'
    t.datetime 'created_at',               null: false
    t.datetime 'updated_at',               null: false
    t.integer  'position', default: 0
    t.integer  'nav_style_id'
    t.index ['nav_style_id'], name: 'index_navbars_on_nav_style_id', using: :btree
    t.index ['website_id'], name: 'index_navbars_on_website_id', using: :btree
  end

  create_table 'pages', force: :cascade do |t|
    t.integer  'website_id'
    t.string   'title'
    t.text     'content'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer  'layout_id'
    t.index ['layout_id'], name: 'index_pages_on_layout_id', using: :btree
    t.index ['website_id'], name: 'index_pages_on_website_id', using: :btree
  end

  create_table 'posts', force: :cascade do |t|
    t.string   'title'
    t.text     'content'
    t.integer  'status'
    t.integer  'blog_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['blog_id'], name: 'index_posts_on_blog_id', using: :btree
  end

  create_table 'users', force: :cascade do |t|
    t.string   'email',                  default: '', null: false
    t.string   'encrypted_password',     default: '', null: false
    t.string   'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer  'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet     'current_sign_in_ip'
    t.inet     'last_sign_in_ip'
    t.datetime 'created_at',                          null: false
    t.datetime 'updated_at',                          null: false
    t.index ['email'], name: 'index_users_on_email', unique: true, using: :btree
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true, using: :btree
  end

  create_table 'websites', force: :cascade do |t|
    t.string   'name'
    t.text     'description'
    t.integer  'user_id'
    t.datetime 'created_at',     null: false
    t.datetime 'updated_at',     null: false
    t.integer  'color_combo_id'
    t.index ['color_combo_id'], name: 'index_websites_on_color_combo_id', using: :btree
    t.index ['user_id'], name: 'index_websites_on_user_id', using: :btree
  end

  create_table 'widgets', force: :cascade do |t|
    t.string   'type'
    t.string   'widgetable_type'
    t.integer  'widgetable_id'
    t.text     'content'
    t.string   'title'
    t.datetime 'created_at',      null: false
    t.datetime 'updated_at',      null: false
    t.integer  'position'
    t.string   'col_span'
    t.string   'image'
    t.index ['widgetable_id'], name: 'index_widgets_on_widgetable_id', using: :btree
    t.index %w(widgetable_type widgetable_id), name: 'index_widgets_on_widgetable_type_and_widgetable_id', using: :btree
    t.index ['widgetable_type'], name: 'index_widgets_on_widgetable_type', using: :btree
  end

  add_foreign_key 'blogs', 'websites'
  add_foreign_key 'links', 'navbars'
  add_foreign_key 'links', 'pages'
  add_foreign_key 'navbars', 'nav_styles'
  add_foreign_key 'navbars', 'websites'
  add_foreign_key 'pages', 'layouts'
  add_foreign_key 'pages', 'websites'
  add_foreign_key 'posts', 'blogs'
  add_foreign_key 'websites', 'color_combos'
  add_foreign_key 'websites', 'users'
end
