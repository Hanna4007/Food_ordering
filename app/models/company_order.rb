# frozen_string_literal: true

class CompanyOrder < ApplicationRecord
  has_many :personal_orders, dependent: :destroy

  before_save :update_company_price

  VALID_STATUS = ['in progress', 'confirmed'].freeze
  validates :status, inclusion: { in: VALID_STATUS }

  scope :company_order_desc, -> { order(updated_at: :desc) }

  def update_company_price
    self.company_price = personal_orders.sum(:total_price)
  end
end
