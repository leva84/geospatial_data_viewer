# frozen_string_literal: true

describe Api::V1::TicketsController, type: :controller do
  describe 'POST #create' do
    subject { post :create, params: params }

    shared_examples :no_successful_creation do
      it 'returns unprocessable entity status' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create new ticket in database' do
        expect { subject }.not_to change(Ticket, :count)
      end

      it 'does not create new excavator in database' do
        expect { subject }.not_to change(Excavator, :count)
      end
    end

    context 'with valid parameters' do
      let(:params) { { json_data: valid_ticket_json } }

      it 'returns created status' do
        expect(subject).to have_http_status(:created)
      end

      it 'creates a new ticket and excavator' do
        subject
        expect(json_response['message']).to eq('Ticket created successfully')
      end

      it 'creates a new ticket and associated excavator in the database' do
        expect { subject }.to change(Ticket, :count).by(1).and change(Excavator, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      let(:params) { { json_data: invalid_ticket_json } }
      let(:errors_message) do
        ["Request number can't be blank, Sequence number can't be blank, Well known text can't be blank"]
      end

      include_examples :no_successful_creation

      it 'returns errors message' do
        subject
        expect(json_response.dig('errors', 'base')).to eq(errors_message)
      end

      it 'logs errors' do
        expect(Rails.logger).to receive(:error).with(/RecordInvalid Error:/)
        subject
      end
    end

    context 'when parameters existing ticket' do
      let(:params) { { json_data: ticket_json } }
      let(:errors_message) { ['Request number has already been taken, Sequence number has already been taken'] }

      before do
        Api::V1::Tickets::CreateTicketCommand.call(json_data: ticket_json)
      end

      include_examples :no_successful_creation

      it 'returns errors message' do
        subject
        expect(json_response.dig('errors', 'base')).to eq(errors_message)
      end

      it 'logs errors' do
        expect(Rails.logger).to receive(:error).with(/RecordInvalid Error:/)
        subject
      end
    end

    context 'with missing parameters' do
      let(:params) { {} }
      let(:errors_message) { ["can't be blank"] }

      include_examples :no_successful_creation

      it 'returns errors message' do
        subject
        expect(json_response.dig('errors', 'json_data')).to eq(errors_message)
      end
    end

    context 'with incorrect parameters ResponseDueDateTime' do
      let(:params) { { json_data: invalid_ticket_time_json } }

      it 'returns created status' do
        subject
        expect(response).to have_http_status(:created)
      end

      it 'creates a new ticket and associated excavator in the database' do
        expect { subject }.to change(Ticket, :count).by(1).and change(Excavator, :count).by(1)
      end

      it 'returns errors message for ResponseDueDateTime' do
        expect(Rails.logger).to receive(:warn).with(/ResponseDueDateTime Warning:/)
        subject
      end

      it 'sets response_due_date_time to one day plus current date' do
        subject
        expect(Ticket.last.response_due_date_time).to be_within(1.second).of(DateTime.now + 1.day)
      end
    end
  end
end
