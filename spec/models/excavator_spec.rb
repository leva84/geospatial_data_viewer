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

  context 'database columns' do
    it { should have_db_column(:ticket_id).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:company_name).of_type(:string) }
    it { should have_db_column(:address).of_type(:string) }
    it { should have_db_column(:crew_on_site).of_type(:boolean) }
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_index(:ticket_id) }
  end

  context 'saving to the database' do
    it 'persists to the database' do
      expect { subject.save }.to change(Excavator, :count).by(1)
    end
  end
end
