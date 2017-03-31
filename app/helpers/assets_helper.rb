module AssetsHelper
  def asset_attribute_names
    %w(name symbol exchange category expense_ratio)
  end

  def format_category(value)
    value.titlecase
  end

  def format_exchange(value)
    value.upcase
  end

  def format_market_cap(value)
    value.titlecase
  end

  def format_style(value)
    value.titlecase
  end
end
