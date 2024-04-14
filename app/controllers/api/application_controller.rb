# frozen_string_literal: true

class Api::ApplicationController < ActionController::API
  before_action :disable_cache

  delegate :t, to: I18n

  private

  def disable_cache
    expires_now
  end
end
