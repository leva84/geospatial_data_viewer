# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

  private

  def resource_not_found(exception)
    @error = exception
    Rails.logger.error "ERROR: #{ exception }"
    render 'errors/not_found', status: :not_found
  end
end
