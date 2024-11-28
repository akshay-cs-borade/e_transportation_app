class ETransportation < ApplicationRecord
  validates :e_transportation_type, inclusion: { in: %w[e-Scooter e-Bike] }
  validates :sensor_type, inclusion: { in: %w[small medium big] }
  validates :owner_id, numericality: { only_integer: true }
  validates :in_zone, inclusion: { in: [true, false] }
  validates :lost_sensor, inclusion: { in: [true, false] }, if: -> { e_transportation_type == 'e-Scooter' }
end
