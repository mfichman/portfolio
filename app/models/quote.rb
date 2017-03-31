class Quote < ApplicationRecord
  belongs_to :asset

  CURRENCY = %w(usd)

  monetize :price_cents

  with_options presence: true do
    validates :price
    validates :price_cents
    validates :price_currency
    validates :quoted_at
  end

  with_options allow_blank: true do
    validates :price, numericality: { greater_than: 0 }
    validates :price_currency, inclusion: { in: CURRENCY }
  end

  scope :in, -> (range) { where('quoted_at >= ? and quoted_at <= ?', range.first, range.last) }
  scope :sorted, -> { order(:quoted_at) }

  def quoted_on
    quoted_at.to_date
  end
end
