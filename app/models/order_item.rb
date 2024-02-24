# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :personal_order
  belongs_to :product

  before_validation :update_attributes_from_product

  private

  def update_attributes_from_product
    self.name = product.name if new_record?
    self.unit_price = product.price if new_record?
    self.total_price = unit_price * quantity
  end
end
