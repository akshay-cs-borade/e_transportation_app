module Api
  module V1
    class ETransportationsController < ApplicationController
      def create
        response = ETransportationService.create_e_transportation(e_transportation_params)
        render json: { message: 'e-Transportation created successfully' }, status: :created
      rescue => e
        render json: { message: "Validation failed: #{e.message}" }, status: :unprocessable_entity
      end

      def index
        render json: ETransportationService.all_e_transportations, status: :ok
      end

      def outside_zone
        render json: ETransportationService.outside_zone_grouped, status: :ok
      end

      private

      def e_transportation_params
        params.require(:e_transportation).permit(:e_transportation_type, :sensor_type, :owner_id, :in_zone, :lost_sensor)
      end
    end
  end
end