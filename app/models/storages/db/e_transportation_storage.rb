module Storages
  class Db::ETransportationStorage < ETransportationStorage
    class << self
      def create(attrs)
        ETransportation.create!(attrs)
      end
    
      def all
        ETransportation.all
      end
    
      def outside_zone_grouped
        data = ETransportation.where(in_zone: false)
                      .group(:e_transportation_type, :sensor_type).count
        data.map { |key, value| [key.join(" - "), value] }.to_h                
      end
    end  
  end
end