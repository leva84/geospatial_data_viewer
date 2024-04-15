# frozen_string_literal: true

class Ticket < ApplicationRecord
  has_one :excavator, dependent: :destroy

  validates :request_number, :sequence_number, presence: true, uniqueness: true
  validates :well_known_text, presence: true
end
