class ResourceRecordSet < ActiveRecord::Base
  attr_accessible :alias_target, :failover, :health_check_id, :hosted_zone_id, :name, :region, :resource_records, :set_identifier, :ttl, :type, :weight
end
