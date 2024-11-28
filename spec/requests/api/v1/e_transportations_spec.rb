require 'rails_helper'

RSpec.describe Api::V1::ETransportationsController, type: :controller do
  let(:valid_attributes) do
    {
      e_transportation_type: 'e-Scooter',
      sensor_type: 'small',
      owner_id: 1,
      in_zone: true,
      lost_sensor: false
    }
  end

  let(:invalid_attributes) do
    {
      e_transportation_type: '',
      sensor_type: '',
      owner_id: nil
    }
  end

  before do
    allow(ENV).to receive(:[]).with('USE_IN_MEMORY').and_return(use_in_memory)
  end

  context 'when using InMemoryETransportationRepository' do
    let(:use_in_memory) { 'true' }

    describe 'POST #create' do
      context 'with valid parameters' do
        it 'creates a new e-Transportation and returns a success message' do
          post :create, params: { e_transportation: valid_attributes }
          
          expect(response).to have_http_status(:created)
          expect(JSON.parse(response.body)['message']).to eq('e-Transportation created successfully')
        end
      end

      context 'with invalid parameters' do
        it 'raises an error when required attributes are missing' do
          post :create, params: { e_transportation: invalid_attributes }
          
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['message']).to eq("Validation failed: E transportation type is not included in the list, Sensor type is not included in the list, Owner is not a number, In zone is not included in the list")
        end
      end
    end

    describe 'GET #index' do
      it 'returns a list of all e-Transportations' do
        ETransportationService.create_e_transportation(valid_attributes)

        get :index
        
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).count).to eq(2)
      end
    end

    describe 'GET #outside_zone' do
      it 'returns grouped e-Transportations outside the zone' do
        ETransportationService.create_e_transportation(
          e_transportation_type: 'e-Bike', 
          sensor_type: 'medium', 
          owner_id: 3, 
          in_zone: false, 
          lost_sensor: false
        )
        
        get :outside_zone
        
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({ "e-Bike - medium" => 1 })
      end
    end
  end

  context 'when using ActiveRecordETransportationRepository' do
    let(:use_in_memory) { 'false' }

    describe 'POST #create' do
      context 'with valid parameters' do
        it 'creates a new e-Transportation and returns a success message' do
          post :create, params: { e_transportation: valid_attributes }
          
          expect(response).to have_http_status(:created)
          expect(JSON.parse(response.body)['message']).to eq('e-Transportation created successfully')
          expect(ETransportation.count).to eq(1)
        end
      end

      context 'with invalid parameters' do
        it 'raises an error when required attributes are missing' do
          post :create, params: { e_transportation: invalid_attributes }
          
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['message']).to eq("Validation failed: Validation failed: E transportation type is not included in the list, Sensor type is not included in the list, Owner is not a number, In zone is not included in the list")
        end
      end
    end

    describe 'GET #index' do
      it 'returns a list of all e-Transportations' do
        ETransportationService.create_e_transportation(valid_attributes)

        get :index
        
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(1)
      end
    end

    describe 'GET #outside_zone' do
      it 'returns grouped e-Transportations outside the zone' do
        ETransportationService.create_e_transportation(
          e_transportation_type: 'e-Bike', 
          sensor_type: 'medium', 
          owner_id: 3, 
          in_zone: false, 
          lost_sensor: false
        )
        
        get :outside_zone
        
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({ "e-Bike - medium" => 1 })
      end
    end
  end
end
