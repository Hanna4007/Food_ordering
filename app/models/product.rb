# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :restaurant
  has_many :order_items
  has_and_belongs_to_many :users
end
