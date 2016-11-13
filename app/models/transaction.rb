class Transaction < ApplicationRecord
  TYPES = %w(Buy Sell)
  CURRENCIES = %w(usd)

  belongs_to :asset
  belongs_to :account

  monetize :amount_cents
  monetize :price_cents

  validates :amount, presence: true
  validates :amount_cents, presence: true
  validates :amount_currency, presence: true
  validates :completed_on, presence: true
  validates :price, presence: true
  validates :price_cents, presence: true
  validates :price_currency, presence: true
  validates :shares, presence: true
  validates :type, presence: true

  validates :amount, numericality: { greater_than: 0 }, allow_blank: true
  validates :amount_currency, inclusion: { in: CURRENCIES }, allow_blank: true
  validates :price, numericality: { greater_than: 0 }, allow_blank: true
  validates :price_currency, inclusion: { in: CURRENCIES }, allow_blank: true
  validates :type, inclusion: { in: TYPES }, allow_blank: true
end

class Buy < Transaction
  def self.model_name
    Transaction.model_name
  end
end

class Sell < Transaction
  def self.model_name
    Transaction.model_name
  end
end
