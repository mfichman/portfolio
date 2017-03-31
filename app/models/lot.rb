class Lot < ApplicationRecord
  belongs_to :asset
  belongs_to :account

  has_many :quotes, through: :asset

  monetize :cost_basis_cents

  with_options presence: true do
    validates :asset
    validates :account
    validates :cost_basis
    validates :cost_basis_cents
    validates :cost_basis_currency
    validates :opened_on
  end

  with_options allow_blank: true do
    validates :cost_basis, numericality: { greater_than: 0 }
    validates :cost_basis_currency, inclusion: { in: Transaction::CURRENCY }
  end

  delegate :category, to: :asset

  def value
    shares * quotes.last.price
  end
end
