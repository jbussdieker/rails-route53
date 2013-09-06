# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130906171552) do

  create_table "health_checks", :force => true do |t|
    t.string   "health_check_id"
    t.string   "ip_address"
    t.integer  "port"
    t.string   "type"
    t.string   "resource_path"
    t.string   "fully_qualified_domain_name"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "hosted_zones", :force => true do |t|
    t.string   "hosted_zone_id"
    t.string   "name"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "resource_record_sets", :force => true do |t|
    t.integer  "hosted_zone_id"
    t.string   "name"
    t.string   "type"
    t.integer  "ttl"
    t.string   "resource_records"
    t.string   "set_identifier"
    t.integer  "weight"
    t.string   "region"
    t.string   "alias_target"
    t.string   "health_check_id"
    t.string   "failover"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
