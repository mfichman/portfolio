module TransactionsHelper
  def transaction_attribute_names
    %w(account type asset shares price amount completed_on)
  end

  def format_account(value)
    value.name
  end

  def format_asset(value)
    value.symbol
  end

  def format_price(value)
    value.format
  end

  def format_amount(value)
    value.format
  end
end
