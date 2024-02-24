# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :restaurant
  has_many :order_items
end
