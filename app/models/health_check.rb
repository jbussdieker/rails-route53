class HealthCheck < ActiveRecord::Base
  attr_accessible :health_check_id, :fully_qualified_domain_name, :ip_address, :port, :resource_path, :type
  self.inheritance_column = nil

  def self.list_health_checks
    client = AWS::Route53::Client.new
    list = []
    done = false
    next_marker = nil
    while done == false
      options = {}
      options.merge!(:marker => next_marker) if next_marker
      resp = client.list_health_checks(options)
      resp[:health_checks].each do |health_check|
        list << health_check
      end
      if resp[:is_truncated]
        next_marker = resp[:next_marker]
      else
        done = true
      end
    end
    list
  end

  def self.sync
    local_list = all
    remote_list = list_health_checks

    # Create missing local ones
    remote_list.each do |health_check|
      if local_list.find {|item| item.health_check_id == health_check[:id]}
      else
        record = {}
        record.merge!(:health_check_id => health_check[:id])
        record.merge!(health_check[:health_check_config])
        create(record)
      end
    end

    # Delete missing remote ones
    local_list.each do |health_check|
      if remote_list.find {|item| item[:id] == health_check.health_check_id}
      else
        health_check.destroy
      end
    end

    nil
  end
end
