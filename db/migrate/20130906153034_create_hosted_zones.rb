class CreateHostedZones < ActiveRecord::Migration
  def change
    create_table :hosted_zones do |t|
      t.string :zone_id
      t.string :name

      t.timestamps
    end
  end
end
