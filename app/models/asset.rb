class Asset < ApplicationRecord
  EXCHANGE = %w(nyse nasdaq mutf)
  CATEGORY = %w(
    large_cap_blend
    large_cap_growth
    large_cap_value
    small_cap_blend
    small_cap_growth
    small_cap_value
    mid_cap_blend
    mid_cap_growth
    mid_cap_value
    international_developed
    international_emerging
    long_term_bond
    intermediate_term_bond
    short_term_bond
    long_term_treasuries
    intermediate_term_treasuries
    short_term_treasuries
    cash
  ).freeze

  has_many :transactions
  has_many :lots
  has_many :quotes

  with_options presence: true do
    validates :category
    validates :exchange
    validates :expense_ratio
    validates :symbol, uniqueness: true
  end

  with_options allow_blank: true do
    validates :category, inclusion: { in: CATEGORY }
    validates :exchange, inclusion: { in: EXCHANGE }
    validates :expense_ratio, numericality: { range: 0..1 }
  end

  def value
    quotes
  end

  def humanize
    name.blank? ? super : name
  end
end
