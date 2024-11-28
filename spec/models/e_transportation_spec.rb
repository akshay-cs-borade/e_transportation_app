require 'rails_helper'

RSpec.describe ETransportation, type: :model do
  it 'is valid with valid attributes' do
    e_transportation = ETransportation.new(
      e_transportation_type: 'e-Bike', 
      sensor_type: 'small', 
      owner_id: 1, 
      in_zone: true, 
      lost_sensor: false
    )
    expect(e_transportation).to be_valid
  end

  it 'is not valid without e_transportation_type' do
    e_transportation = ETransportation.new(
      sensor_type: 'small', 
      owner_id: 1, 
      in_zone: true, 
      lost_sensor: false
    )
    expect(e_transportation).to_not be_valid
    expect(e_transportation.errors[:e_transportation_type]).to include("is not included in the list")
  end

  it 'is not valid without sensor_type' do
    e_transportation = ETransportation.new(
      e_transportation_type: 'e-Bike', 
      owner_id: 1, 
      in_zone: true, 
      lost_sensor: false
    )
    expect(e_transportation).to_not be_valid
    expect(e_transportation.errors[:sensor_type]).to include("is not included in the list")
  end

  it 'is not valid without owner_id' do
    e_transportation = ETransportation.new(
      e_transportation_type: 'e-Bike', 
      sensor_type: 'small', 
      in_zone: true, 
      lost_sensor: false
    )
    expect(e_transportation).to_not be_valid
    expect(e_transportation.errors[:owner_id]).to include("is not a number")
  end

  it 'is not valid without in_zone being true or false' do
    e_transportation = ETransportation.new(
      e_transportation_type: 'e-Bike', 
      sensor_type: 'small', 
      owner_id: 1, 
      lost_sensor: false
    )
    expect(e_transportation).to_not be_valid
    expect(e_transportation.errors[:in_zone]).to include("is not included in the list")
  end

  it 'is not valid without lost_sensor being true or false' do
    e_transportation = ETransportation.new(
      e_transportation_type: 'e-Scooter', 
      sensor_type: 'small', 
      owner_id: 1, 
      in_zone: true
    )
    
    expect(e_transportation).to_not be_valid
    expect(e_transportation.errors[:lost_sensor]).to include("is not included in the list")
  end
end
