# frozen_string_literal: true

class Restaurant < ApplicationRecord
  has_many :products, dependent: :destroy
end
