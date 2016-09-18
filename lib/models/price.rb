require_relative '../db/migrations'

class Price < ActiveRecord::Base
  validates :offer_id, :date, presence: true
  validates :price, numericality: true
  validates :date, uniqueness: { scope: :offer_id }
end
