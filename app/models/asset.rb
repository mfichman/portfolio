class Asset < ApplicationRecord
  ASSET_CLASSES = %w(stock bond etf cash mutual_fund)
  MARKET_CAPS = %w(large medium small)
  STYLES = %w(value growth blend)
  EXCHANGES = %w(nyse nasdaq)

  has_many :transactions

  validates :asset_class, presence: true, inclusion: { in: ASSET_CLASSES }
  validates :exchange, presence: true, inclusion: { in: EXCHANGES }
  validates :expense_ratio, allow_nil: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
  validates :market_cap, presence: true, inclusion: { in: MARKET_CAPS }
  validates :name, presence: true
  validates :style, presence: true, inclusion: { in: STYLES }
  validates :symbol, presence: true

  def humanize
    name.blank? ? super : name
  end
end
