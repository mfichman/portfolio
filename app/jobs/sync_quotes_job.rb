class SyncQuotesJob < ApplicationJob
  def perform(asset_id)
    asset = Asset.find(asset_id)

    chart = IEX::Resources::Chart.get(asset.symbol, '5y')

    quote_attributes = chart.map do |entry|
      {
        quoted_on: entry.date,
        open: entry.open,
        high: entry.high,
        low: entry.low,
        close: entry.close,
        volume: entry.volume,
        asset: asset,
      }
    end

    Quote.upsert!(quote_attributes)
  end
end
