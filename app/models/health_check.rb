class HealthCheck < ActiveRecord::Base
  attr_accessible :fully_qualified_domain_name, :health_check_id, :ip_address, :port, :resource_path, :type
end
