class HealthCheck < ActiveRecord::Base
  attr_accessible :fully_qualified_domain_name, :health_check_id, :ip_address, :port, :resource_path, :type
  self.inheritance_column = nil

  def self.each_health_check(&block)
    client = AWS::Route53::Client.new
    done = false
    next_marker = nil
    while done == false
      options = {}
      options.merge!(:marker => next_marker) if next_marker
      resp = client.list_health_checks(options)
      resp[:health_checks].each do |health_check|
        yield(health_check)
      end
      if resp[:is_truncated]
        next_marker = resp[:next_marker]
      else
        done = true
      end
    end
  end

  def self.sync
    each_health_check do |health_check|
      record = {}
      record.merge!(:health_check_id => health_check[:id])
      record.merge!(health_check[:health_check_config])
      create(record)
    end
  end
end
