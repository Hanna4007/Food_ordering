# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @products = @restaurant.products
    @order_items = current_order.order_items.new if current_user.present?
  end
end
