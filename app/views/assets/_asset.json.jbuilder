json.extract! asset, :id, :name, :symbol, :market_cap, :style, :asset_class, :expense_ratio, :created_at, :updated_at
json.url asset_url(asset, format: :json)