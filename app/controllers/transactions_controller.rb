class TransactionsController < SimpleController
  self.permitted_params = %w(asset_id type amount_cents amount_currency shares price_cents price_currency completed_on account_id)

  before_action :set_accounts, only: [:edit, :create, :update, :new]
  before_action :set_assets, only: [:edit, :create, :update, :new]

  def set_accounts
    @accounts = Account.all
  end

  def set_assets
    @assets = Asset.all
  end
end
