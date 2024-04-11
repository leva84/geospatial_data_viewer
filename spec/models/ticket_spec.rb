# frozen_string_literal: true

describe Ticket, type: :model do
  subject { build(:ticket) }

  context 'associations' do
    it { should have_one(:excavator) }
  end

  context 'validations' do
    it { should validate_presence_of(:request_number) }
    it { should validate_presence_of(:sequence_number) }
    it { should validate_presence_of(:well_known_text) }
    it { should validate_uniqueness_of(:request_number) }
    it { should validate_uniqueness_of(:sequence_number) }
  end

  context 'database columns' do
    it { should have_db_column(:request_number).of_type(:string) }
    it { should have_db_column(:sequence_number).of_type(:string) }
    it { should have_db_column(:request_type).of_type(:string) }
    it { should have_db_column(:request_action).of_type(:string) }
    it { should have_db_column(:response_due_date_time).of_type(:datetime) }
    it { should have_db_column(:primary_service_area_code).of_type(:string) }
    it { should have_db_column(:additional_service_area_codes).of_type(:string).with_options(default: [], array: true) }
    it { should have_db_column(:well_known_text).of_type(:geography) }
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  context 'saving to the database' do
    let(:polygon_class) { RGeo::Geographic::SphericalPolygonImpl }

    it 'persists to the database' do
      expect { subject.save }.to change(Ticket, :count).by(1)
    end

    it 'creates the correct class for polygon attribute' do
      subject.save
      expect(Ticket.last.well_known_text.class).to eq(polygon_class)
    end
  end
end
