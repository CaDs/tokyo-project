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

ActiveRecord::Schema.define(version: 6) do
  create_table 'accounts', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci' do |t|
    t.string   'name'
    t.string   'surname'
    t.string   'email'
    t.string   'crypted_password'
    t.string   'role'
    t.datetime 'created_at',       null: false
    t.datetime 'updated_at',       null: false
  end

  create_table 'areas', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci' do |t|
    t.integer  'ward_id'
    t.string   'name'
    t.string   'url_title'
    t.string   'description'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
    t.index ['ward_id'], name: 'fk_rails_5385c2a1ca', using: :btree
  end

  create_table 'pictures', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci' do |t|
    t.integer  'vision_id'
    t.integer  'account_id'
    t.string   'flickr_id'
    t.string   'longitude'
    t.string   'latitude'
    t.text     'description_en', limit: 65_535
    t.text     'description_es', limit: 65_535
    t.text     'description_jp', limit: 65_535
    t.boolean  'is_published'
    t.datetime 'schedule_at'
    t.datetime 'created_at',                   null: false
    t.datetime 'updated_at',                   null: false
    t.index ['account_id'], name: 'fk_rails_e141f5c649', using: :btree
    t.index ['vision_id'], name: 'fk_rails_f76642250a', using: :btree
  end

  create_table 'posts', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci' do |t|
    t.integer  'account_id'
    t.string   'title'
    t.text     'body', limit: 65_535
    t.boolean  'is_published'
    t.datetime 'created_at',                 null: false
    t.datetime 'updated_at',                 null: false
    t.index ['account_id'], name: 'fk_rails_ff02f0408e', using: :btree
  end

  create_table 'visions', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci' do |t|
    t.integer  'area_id'
    t.integer  'account_id'
    t.string   'title'
    t.string   'wiki_url'
    t.string   'meta_keywords'
    t.string   'meta_description'
    t.string   'url_title'
    t.text     'short_description', limit: 65_535
    t.text     'body',              limit: 65_535
    t.datetime 'created_at',                      null: false
    t.datetime 'updated_at',                      null: false
    t.index ['account_id'], name: 'fk_rails_8a6d4a7ed3', using: :btree
    t.index ['area_id'], name: 'fk_rails_3998e17314', using: :btree
  end

  create_table 'wards', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci' do |t|
    t.string   'name'
    t.string   'description'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
  end

  add_foreign_key 'areas', 'wards', on_delete: :cascade
  add_foreign_key 'pictures', 'accounts', on_delete: :cascade
  add_foreign_key 'pictures', 'visions', on_delete: :cascade
  add_foreign_key 'posts', 'accounts', on_delete: :cascade
  add_foreign_key 'visions', 'accounts', on_delete: :cascade
  add_foreign_key 'visions', 'areas', on_delete: :cascade
end
