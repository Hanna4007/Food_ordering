# frozen_string_literal: true

class PersonalOrder < ApplicationRecord
  belongs_to :company_order, optional: true
  belongs_to :user
  has_many :order_items, dependent: :destroy

  before_save :update_total_price

  VALID_STATUS = ['in progress', 'confirmed'].freeze
  validates :status, inclusion: { in: VALID_STATUS }

  scope :personal_order_desc, -> { order(updated_at: :desc) }

  def update_total_price
    self.total_price = order_items.map { |order_item| order_item.quantity * order_item.unit_price }.sum
  end
end
