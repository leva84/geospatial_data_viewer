# frozen_string_literal: true

class Api::ApplicationController < ActionController::API
  before_action :disable_cache

  private

  def disable_cache
    expires_now
  end
end
