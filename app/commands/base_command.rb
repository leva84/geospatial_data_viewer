# frozen_string_literal: true

class BaseCommand
  include ActiveModel::Model

  attr_reader :args

  def initialize(*args)
    @args = args
    super
  end

  def call
    raise NotImplementedError
  end

  def self.call(*args)
    new(args.inject({}, :merge)).tap(&:call)
  end

  def ok?
    status == :ok
  end

  def error?
    status == :error
  end

  def status
    errors.any? ? :error : :ok
  end

  def valid?
    ok? && super
  end
end
