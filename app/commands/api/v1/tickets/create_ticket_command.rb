# frozen_string_literal: true

class Api::V1::Tickets::CreateTicketCommand < BaseCommand
  TICKET_DATA_KEYS = %w[
    RequestNumber
    SequenceNumber
    RequestType
    RequestAction
    DateTimes
    ServiceArea
    ExcavationInfo
  ].freeze

  attr_accessor :json_data
  attr_reader :ticket

  validates :json_data, presence: true

  def call
    return unless valid?

    ActiveRecord::Base.transaction do
      @ticket = create_ticket
      create_excavator
    end
  rescue ActiveRecord::RecordInvalid => e
    handle_record_invalid_error(e)
  end

  private

  def create_ticket
    Ticket.create!(ticket_attributes)
  end

  def create_excavator
    Excavator.create!(excavator_attributes)
  end

  def ticket_attributes
    {
      request_number: ticket_data['RequestNumber'],
      sequence_number: ticket_data['SequenceNumber'],
      request_type: ticket_data['RequestType'],
      request_action: ticket_data['RequestAction'],
      response_due_date_time: response_due_date_time,
      primary_service_area_code: ticket_data.dig('ServiceArea', 'PrimaryServiceAreaCode', 'SACode'),
      additional_service_area_codes: ticket_data.dig('ServiceArea', 'AdditionalServiceAreaCodes', 'SACode'),
      well_known_text: ticket_data.dig('ExcavationInfo', 'DigsiteInfo', 'WellKnownText')
    }
  end

  def excavator_attributes
    {
      company_name: excavator_data['CompanyName'],
      address: excavator_data['Address'],
      crew_on_site: ActiveRecord::Type::Boolean.new.cast(excavator_data['CrewOnSite']),
      ticket: ticket
    }
  end

  def json_data_to_hash
    @json_data_to_hash ||= json_data.present? ? JSON.parse(json_data) : {}
  end

  def ticket_data
    @ticket_data ||= json_data_to_hash.select { |key, _| TICKET_DATA_KEYS.include?(key) }
  end

  def excavator_data
    @excavator_data ||= json_data_to_hash['Excavator'] || {}
  end

  def response_due_date_time
    DateTime.parse(ticket_data.dig('DateTimes', 'ResponseDueDateTime'))
  rescue ArgumentError, TypeError => e
    handle_response_due_date_error(e)
  end

  def handle_record_invalid_error(error)
    Rails.logger.error "RecordInvalid Error: #{ error }"
    errors.add(:base, error.record.errors.full_messages.join(', '))
  end

  def handle_response_due_date_error(error)
    Rails.logger.warn "ResponseDueDateTime Warning: #{ error }"
    DateTime.now + 1.day
  end
end
