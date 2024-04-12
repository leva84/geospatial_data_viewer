# frozen_string_literal: true

module TicketsHelper
  def wkt
    @ticket.well_known_text
  end
end
