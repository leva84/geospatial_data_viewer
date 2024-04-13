# frozen_string_literal: true

class TicketsController < ApplicationController
  def index
    @tickets = Ticket.order(id: :desc)
  end

  def show
    @ticket = Ticket.find(params[:id])
    @excavator = @ticket.excavator

    raise ActiveRecord::RecordNotFound, "Couldn't find Excavator for Ticket with 'id'=#{params[:id]}" if @excavator.nil?
  end
end
