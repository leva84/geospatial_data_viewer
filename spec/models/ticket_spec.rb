# frozen_string_literal: true

describe Ticket, type: :model do
  subject { build(:ticket) }

  context 'associations' do
    it { should have_one(:excavator) }
  end

  context 'validations' do
    it { should validate_presence_of(:request_number) }
    it { should validate_presence_of(:sequence_number) }
    it { should validate_presence_of(:excavator) }

    it { should validate_uniqueness_of(:request_number) }
    it { should validate_uniqueness_of(:sequence_number) }
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
