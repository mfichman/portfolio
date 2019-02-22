module AccountsHelper
  def account_attribute_names
    %w(name institution account_number tax_status)
  end

  def format_tax_status(value)
    value.humanize
  end
end
