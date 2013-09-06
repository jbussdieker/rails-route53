class HostedZone < ActiveRecord::Base
  attr_accessible :hosted_zone_id, :name
  has_many :resource_record_sets

  def list_resource_record_sets
    client = AWS::Route53::Client.new
    list = []
    done = false
    next_record = nil
    next_type = nil
    while done == false
      options = {:hosted_zone_id => hosted_zone_id}
      options.merge!(:start_record_name => next_record) if next_record
      options.merge!(:start_record_type => next_type) if next_type
      resp = client.list_resource_record_sets(options)
      resp[:resource_record_sets].each do |record|
        list << record
      end
      if resp[:is_truncated]
        next_record = resp[:next_record_name]
        next_type = resp[:next_record_type]
      else
        done = true
      end
    end
    list
  end

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

  def sync
    local_list = resource_record_sets
    remote_list = list_resource_record_sets

    # Create missing local ones
    remote_list.each do |rrs|
      local = local_list.find do |item|
        item.name == rrs[:name] &&
        item.type == rrs[:type] &&
        item.set_identifier == rrs[:set_identifier]
      end

      if local
      else
        record = rrs
        resource_record_sets.create(record)
      end
    end

    # Delete missing remote ones
    local_list.each do |rrs|
      remote = remote_list.find do |item|
        rrs.name == item[:name] &&
        rrs.type == item[:type] &&
        rrs.set_identifier == item[:set_identifier]
      end

      if remote
      else
        hosted_zone.destroy
      end
    end

    nil
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
