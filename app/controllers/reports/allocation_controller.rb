class Reports::AllocationController < ApplicationController
  before_action :set_accounts
  before_action :set_lots
  before_action :set_labels
  before_action :set_values

  helper ChartHelper

  private

  def set_accounts
    @accounts = Account.all
  end

  def set_lots
    @lots = Lot.where(account: @accounts).includes(:asset, :quotes).group_by(&:category)
  end

  def set_labels
    @labels = @lots.keys.sort
  end

  def set_values
    @values = @labels.map { |label| @lots[label].sum(&:value) }
  end
end
