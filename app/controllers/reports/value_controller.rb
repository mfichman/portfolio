class Reports::ValueController < ApplicationController
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
    @values = @labels.map do |date|
      @assets.sum do |asset|
        asset.quotes.reverse.bsearch { |quote| quote.quoted_on <= date }.price
      end
    end
  end
end
