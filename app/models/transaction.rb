class Transaction < ApplicationRecord
  TYPE = %w(Buy Sell)
  CURRENCY = %w(usd)

  belongs_to :asset
  belongs_to :account

  has_many :quotes

  monetize :amount_cents
  monetize :price_cents

  with_options presence: true do
    validates :amount
    validates :amount_cents
    validates :amount_currency
    validates :completed_on
    validates :price
    validates :price_cents
    validates :price_currency
    validates :shares
    validates :type
  end

  with_options allow_blank: true do
    validates :amount, numericality: { greater_than: 0 }
    validates :amount_currency, inclusion: { in: CURRENCY }
    validates :price, numericality: { greater_than: 0 }
    validates :price_currency, inclusion: { in: CURRENCY }
    validates :type, inclusion: { in: TYPE }
  end
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
