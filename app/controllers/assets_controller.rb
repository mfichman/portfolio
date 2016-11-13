class AssetsController < SimpleController
  self.permitted_params = %w(name symbol market_cap style asset_class expense_ratio exchange)
end
