json.extract! asset, :id, :name, :symbol, :category, :expense_ratio, :created_at, :updated_at
json.url asset_url(asset, format: :json)
