module Storages
  class InMemory::ETransportationStorage < ETransportationStorage
    @data = []

    class << self
      def create(attrs)
        e_transportation = ETransportation.new(attrs)
        if e_transportation.valid?
          @data << e_transportation.attributes
        else
          raise e_transportation.errors 
        end     
      end

      def all
        @data
      end

      def outside_zone_grouped
        @data.select { |et| et["in_zone"] == false }.group_by { |et| [et["e_transportation_type"], et["sensor_type"]] }.transform_values { |value| value.size }
      end
    end
  end
end  
