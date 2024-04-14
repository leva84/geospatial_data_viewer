# frozen_string_literal: true

module TicketsHelper
  def wkt
    @ticket.well_known_text
  end

  def ticket_attr(attribute)
    Ticket.human_attribute_name(attribute)
  end

  def excavator_attr(attribute)
    Excavator.human_attribute_name(attribute)
  end
end
