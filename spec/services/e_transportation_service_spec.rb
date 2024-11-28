require 'rails_helper'

RSpec.describe ETransportationService, type: :service do
  let(:valid_attributes) do
    {
      e_transportation_type: 'e-Scooter',
      sensor_type: 'small',
      owner_id: 1,
      in_zone: true,
      lost_sensor: false
    }
  end

  let(:outside_zone_attributes) do
    {
      e_transportation_type: 'e-Bike',
      sensor_type: 'medium',
      owner_id: 2,
      in_zone: false,
      lost_sensor: false
    }
  end

  describe '.storage' do
    context 'when USE_IN_MEMORY is true' do
      before do
        allow(ENV).to receive(:[]).with('USE_IN_MEMORY').and_return('true')
      end

      it 'returns InMemory storage' do
        expect(ETransportationService.storage).to eq(::Storages::InMemory::ETransportationStorage)
      end
    end

    context 'when USE_IN_MEMORY is false' do
      before do
        allow(ENV).to receive(:[]).with('USE_IN_MEMORY').and_return('false')
      end

      it 'returns DB storage' do
        expect(ETransportationService.storage).to eq(::Storages::Db::ETransportationStorage)
      end
    end
  end

  describe '.use_in_memory?' do
    it 'returns true when USE_IN_MEMORY is true' do
      allow(ENV).to receive(:[]).with('USE_IN_MEMORY').and_return('true')
      expect(ETransportationService.use_in_memory?).to be true
    end

    it 'returns false when USE_IN_MEMORY is false' do
      allow(ENV).to receive(:[]).with('USE_IN_MEMORY').and_return('false')
      expect(ETransportationService.use_in_memory?).to be false
    end
  end

  describe '.create_e_transportation' do
    it 'delegates creation to the storage' do
      storage_double = double('Storage')
      allow(ETransportationService).to receive(:storage).and_return(storage_double)
      expect(storage_double).to receive(:create).with(valid_attributes)

      ETransportationService.create_e_transportation(valid_attributes)
    end
  end

  describe '.all_e_transportations' do
    it 'delegates retrieval of all e-Transportations to the storage' do
      storage_double = double('Storage')
      allow(ETransportationService).to receive(:storage).and_return(storage_double)
      expect(storage_double).to receive(:all)

      ETransportationService.all_e_transportations
    end
  end

  describe '.outside_zone_grouped' do
    it 'delegates retrieval of grouped e-Transportations outside the zone to the storage' do
      storage_double = double('Storage')
      allow(ETransportationService).to receive(:storage).and_return(storage_double)
      expect(storage_double).to receive(:outside_zone_grouped)

      ETransportationService.outside_zone_grouped
    end
  end
end
