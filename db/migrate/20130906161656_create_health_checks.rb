class CreateHealthChecks < ActiveRecord::Migration
  def change
    create_table :health_checks do |t|
      t.string :health_check_id
      t.string :ip_address
      t.integer :port
      t.string :type
      t.string :resource_path
      t.string :fully_qualified_domain_name

      t.timestamps
    end
  end
end
