class CreateResourceRecordSets < ActiveRecord::Migration
  def change
    create_table :resource_record_sets do |t|
      t.integer :hosted_zone_id
      t.string :name
      t.string :type
      t.integer :ttl
      t.string :resource_records
      t.string :set_identifier
      t.integer :weight
      t.string :region
      t.string :alias_target
      t.string :health_check_id
      t.string :failover

      t.timestamps
    end
  end
end
