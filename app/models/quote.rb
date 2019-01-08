class Quote < ApplicationRecord
  belongs_to :asset

  CURRENCY = %w(USD)

  monetize :high_cents, with_currency: :usd, numericality: { greater_than: 0 }
  monetize :low_cents, with_currency: :usd, numericality: { greater_than: 0 }
  monetize :open_cents, with_currency: :usd, numericality: { greater_than: 0 }
  monetize :close_cents, with_currency: :usd, numericality: { greater_than: 0 }

  validates :quoted_on, presence: true
  validates :volume, presence: true

  validates :high, presence: true, money: true
  validates :low, presence: true, money: true
  validates :open, presence: true, money: true
  validates :close, presence: true, money: true

  validates :high_currency, inclusion: { in: CURRENCY }
  validates :low_currency, inclusion: { in: CURRENCY }
  validates :open_currency, inclusion: { in: CURRENCY }
  validates :close_currency, inclusion: { in: CURRENCY }

  scope :in, -> (range) { where('quoted_on >= ? and quoted_on <= ?', range.first, range.last) }
  scope :sorted, -> { order(:quoted_at) }
end
