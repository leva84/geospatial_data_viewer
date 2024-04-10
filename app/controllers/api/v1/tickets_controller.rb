# frozen_string_literal: true

class Api::V1::TicketsController < Api::ApplicationController
  def create
    ticket = Ticket.new
    if ticket.save
      render json: { ticket: ticket }, status: :created
    else
      render json: { errors: ticket.errors }, status: :unprocessable_entity
    end
  end
end
