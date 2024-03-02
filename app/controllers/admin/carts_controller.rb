# frozen_string_literal: true

module Admin
  class CartsController < ApplicationController
    def edit
      @company_order = CompanyOrder.find_by(status: 'in progress')
      if params[:focus] == 'restaurant'
        @restaurant_order_items = OrderItem.ordered_by_restaurant 
        @grouped_order_items = @restaurant_order_items.group_by { |order_item| order_item.product.restaurant }
        @restaurant_total_prices = {}
        @grouped_order_items.each do |restaurant, order_items|
          @restaurant_total_prices[restaurant] = order_items.map { |order_item| order_item.total_price }.sum
        end
      end

      return unless @company_order.nil?
      flash[:warning] = 'Company cart is empty'
      redirect_to root_path
    end

    def update
      @company_order = CompanyOrder.find_by(status: 'in progress')
      @company_order.update(status: 'confirmed')
      redirect_to restaurants_path
    end
  end
end
