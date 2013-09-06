class HostedZone < ActiveRecord::Base
  attr_accessible :hosted_zone_id, :name

  def self.list_hosted_zones
    client = AWS::Route53::Client.new
    list = []
    done = false
    next_marker = nil
    while done == false
      options = {}
      options.merge!(:marker => next_marker) if next_marker
      resp = client.list_hosted_zones(options)
      resp[:hosted_zones].each do |hosted_zone|
        list << hosted_zone
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
    remote_list = list_hosted_zones

    # Create missing local ones
    remote_list.each do |hosted_zone|
      if local_list.find {|item| item.hosted_zone_id == hosted_zone[:id]}
      else
        record = {:hosted_zone_id => hosted_zone[:id]}
        record.merge!(:name => hosted_zone[:name])
        create(record)
      end
    end

    # Delete missing remote ones
    local_list.each do |hosted_zone|
      if remote_list.find {|item| item[:id] == hosted_zone.hosted_zone_id}
      else
        hosted_zone.destroy
      end
    end

    nil
  end
end
