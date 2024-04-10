# frozen_string_literal: true

describe Api::V1::TicketsController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_json) { File.read('spec/fixtures/valid_ticket_data.json') }

      it 'creates a new ticket and excavator' do
        post :create, params: { ticket_data: valid_json }

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include('ticket')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_json) { File.read('spec/fixtures/invalid_ticket_data.json') }

      it 'returns unprocessable entity status' do
        post :create, params: { ticket_data: invalid_json }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('errors')
      end
    end
  end
end
