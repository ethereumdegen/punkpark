class Account < ApplicationRecord

  validates :eth_address, uniqueness: true, presence: true

  has_many :providers
end
