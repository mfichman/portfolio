accounts = Account.create!([
  {
    account_number: '8310-3992',
    institution: 'Schwab',
    name: 'IRA',
    tax_status: 'ira'
  }
])

assets = Asset.create!([
  {
    name: 'Intel',
    symbol: 'INTC',
    exchange: 'nasdaq',
    category: 'large_cap_growth',
    expense_ratio: 0
  },
  {
    name: 'Google',
    symbol: 'GOOG',
    exchange: 'nasdaq',
    category: 'mid_cap_growth',
    expense_ratio: 0,
  },
  {
    name: 'Microsoft',
    symbol: 'MSFT',
    exchange: 'nasdaq',
    category: 'small_cap_growth',
    expense_ratio: 0,
  },
  {
    name: 'Bond Etf',
    symbol: 'BND',
    exchange: 'nasdaq',
    category: 'intermediate_term_bond',
    expense_ratio: 0,
  }
]).cycle

#quotes = Quote.create!(100.times.flat_map { |d|
#  r = Random.rand(1000..2000)
#  Asset.all.where(id: 1).map do |asset|
#    r += Random.rand(1..2)
#    {
#      price_cents: r,
#      price_currency: 'usd',
#      asset: assets.next,
#      quoted_at: DateTime.now - d.days,
#    }
#  end
#})

lots = Lot.create!(100.times.flat_map { |d|
  {
    cost_basis_cents: Random.rand(100000..200000),
    cost_basis_currency: 'usd',
    shares: Random.rand(10..60),
    opened_on: DateTime.now,
    account: accounts.first,
    asset: assets.next
  }
})
