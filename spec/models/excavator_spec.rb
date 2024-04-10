# frozen_string_literal: true

describe Excavator, type: :model do
  subject { build(:excavator) }

  context 'associations' do
    it { should belong_to(:ticket) }
  end

  context 'validations' do
    it { should validate_presence_of(:ticket) }
    it { should validate_presence_of(:company_name) }
    it { should validate_presence_of(:address) }
  end

  context 'saving to the database' do
    it 'persists to the database' do
      expect { subject.save }.to change(Excavator, :count).by(1)
    end
  end
end
