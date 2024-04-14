# frozen_string_literal: true

describe TicketsController, type: :controller do
  describe 'GET #index' do
    subject { get :index }

    let!(:tickets) { create_list(:ticket, 15) }
    let(:default_per_page) { described_class::DEFAULT_PER_PAGE }

    it 'returns ok status' do
      expect(subject).to have_http_status(:ok)
    end

    it 'assigns all tickets to @tickets' do
      subject
      expect(assigns(:tickets)).to eq(tickets.reverse.first(default_per_page))
    end

    it 'renders the index template' do
      subject
      expect(response).to render_template(:index)
    end

    it 'paginates @tickets' do
      subject
      expect(assigns(:tickets).current_page).to eq(1)
      expect(assigns(:tickets).limit_value).to eq(default_per_page)
    end
  end

  describe 'GET #show' do
    subject { get :show, params: params }

    context 'when a ticket and excavator exists' do
      let(:params) { { id: ticket.id } }
      let(:ticket) { create(:ticket) }
      let(:excavator) { ticket.excavator }

      it 'returns ok status' do
        expect(subject).to have_http_status(:ok)
      end

      it 'assigns the requested ticket to @ticket' do
        subject
        expect(assigns(:ticket)).to eq(ticket)
      end

      it 'assigns the associated excavator to @excavator' do
        subject
        expect(assigns(:excavator)).to eq(excavator)
        expect(assigns(:ticket).excavator).to eq(assigns(:excavator))
      end

      it 'renders the show template' do
        expect(subject).to render_template(:show)
      end
    end

    context "when the ticket doesn't exist" do
      let(:params) { { id: 'nonexistent_id' } }
      let(:error_message) { "Couldn't find Ticket with 'id'=#{ params[:id] }" }

      it 'returns not_found status' do
        expect(subject).to have_http_status(:not_found)
      end

      it 'assigns error to @error' do
        subject
        expect(assigns(:error).message).to eq error_message
      end

      it 'logs errors' do
        expect(Rails.logger).to receive(:error).with(/#{ error_message }/)
        subject
      end

      it 'renders the not_found template' do
        expect(subject).to render_template(:not_found)
      end
    end

    context "when the excavator doesn't exist" do
      let(:params) { { id: ticket.id } }
      let(:ticket) { create(:ticket, excavator: nil) }
      let(:error_message) { "Couldn't find Excavator for Ticket with 'id'=#{ params[:id] }" }

      it 'returns not_found status' do
        expect(subject).to have_http_status(:not_found)
      end

      it 'assigns error to @error' do
        subject
        expect(assigns(:error).message).to match error_message
      end

      it 'logs errors' do
        expect(Rails.logger).to receive(:error).with(/#{ error_message }/)
        subject
      end

      it 'renders the not_found template' do
        expect(subject).to render_template(:not_found)
      end
    end
  end
end
