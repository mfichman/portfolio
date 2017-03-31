class Account < ApplicationRecord
  TAX_STATUS = %w(401k ira roth_401k roth_ira taxable)

  has_many :transactions
  has_many :lots
  has_many :assets, through: :lots

  with_options presence: true do
    validates :account_number
    validates :institution
    validates :name
    validates :tax_status
  end

  with_options allow_blank: true do
    validates :tax_status, inclusion: { in: TAX_STATUS }
  end

  def humanize
    name.blank? ? super : name
  end
end
