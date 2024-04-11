# frozen_string_literal: true

module JsonHelpers
  def json_response
    JSON.parse(response.body)
  end

  def ticket_json
    File.read('spec/fixtures/ticket_data.json')
  end

  def ticket_data
    JSON.parse(ticket_json)
  end

  def valid_ticket_json
    data = ticket_data
    data['RequestNumber'] = SecureRandom.uuid
    data['SequenceNumber'] = SecureRandom.hex(4)

    JSON.generate(data)
  end

  def invalid_ticket_json
    data = ticket_data
    data['RequestNumber'] = nil
    data['SequenceNumber'] = nil
    data['ExcavationInfo']['DigsiteInfo']['WellKnownText'] = nil

    JSON.generate(data)
  end

  def invalid_ticket_time_json
    data = ticket_data
    data['RequestNumber'] = SecureRandom.uuid
    data['SequenceNumber'] = SecureRandom.hex(4)
    data['DateTimes']['ResponseDueDateTime'] = nil

    JSON.generate(data)
  end
end
