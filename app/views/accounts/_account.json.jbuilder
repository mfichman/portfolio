json.extract! account, :id, :name, :account_number, :institution, :created_at, :updated_at
json.url account_url(account, format: :json)