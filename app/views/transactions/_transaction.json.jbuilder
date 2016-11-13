json.extract! transaction, :id, :asset_id, :type, :amount, :completed_on, :account_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)