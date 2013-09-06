class HostedZone < ActiveRecord::Base
  attr_accessible :hosted_zone_id, :name

  def self.sync
    r53 = AWS::Route53.new
    r53.hosted_zones.each do |zone|
      hosted_zone = find_by_zone_id(zone.id)
      if !hosted_zone
        create(:zone_id => zone.id, :name => zone.name)
      end
    end
  end
end
