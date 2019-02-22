class Reports::PriceController < ApplicationController
  before_action :set_range
  before_action :set_assets
  before_action :set_labels
  before_action :set_values

  helper ChartHelper

  private

  def set_range
    @range = (Date.today - 100.days)..Date.today
  end

  def set_assets
    @assets = Asset.includes(:quotes).merge(Quote.in(@range).sorted).references(:quotes)
  end

  def set_labels
    @labels = Quote.in(@range).sorted.map(&:quoted_on).uniq
  end

  def set_values
    @values = @assets.map do |asset|
      @labels.map do |date|
        asset.quotes.reverse.bsearch { |quote| quote.quoted_on <= date }.close
      end
    end
  end
end
