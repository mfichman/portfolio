class Account < ApplicationRecord
  has_many :transactions

  validates :account_number, presence: true
  validates :institution, presence: true
  validates :name, presence: true
end