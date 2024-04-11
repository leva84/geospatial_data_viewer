# frozen_string_literal: true

class Api::V1::TicketsController < Api::ApplicationController
  def create
    command = Api::V1::Tickets::CreateTicketCommand.call(json_data: params[:json_data])

    if command.ok?
      render json: { message: 'Ticket created successfully' }, status: :created
    else
      render json: { errors: command.errors }, status: :unprocessable_entity
    end
  end
end
