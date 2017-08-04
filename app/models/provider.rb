class Provider < ApplicationRecord

  validates :account_id, presence: true

  validates :account_id, uniqueness: { scope: :name }


  belongs_to :account
end
