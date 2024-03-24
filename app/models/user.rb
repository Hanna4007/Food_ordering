# frozen_string_literal: true

class User < ApplicationRecord
  has_many :personal_orders, dependent: :destroy
  has_and_belongs_to_many :products
end
