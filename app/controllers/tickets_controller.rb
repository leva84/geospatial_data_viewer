# frozen_string_literal: true

class TicketsController < ApplicationController
  def index
    @tickets = Ticket.order(id: :desc)
  end

  def show
    @ticket = Ticket.find(params[:id])
    @excavator = @ticket.excavator

    return unless @excavator.nil?

    raise ActiveRecord::RecordNotFound, t('controllers.tickets.show.errors.excavator_not_found', id: params[:id])
  end
end
