# frozen_string_literal: true

module TicketsHelper
  def wkt
    @ticket.well_known_text
  end

  def row_number(index)
    index + 1 + ((@tickets.current_page - 1) * @tickets.limit_value)
  end

  def paginate_tickets(tickets)
    paginate tickets,
             theme: 'bootstrap-5',
             pagination_class: 'pagination-sm flex-wrap justify-content-center',
             nav_class: 'd-inline-block'
  end

  def ticket_attr(attribute)
    Ticket.human_attribute_name(attribute)
  end

  def excavator_attr(attribute)
    Excavator.human_attribute_name(attribute)
  end
end
