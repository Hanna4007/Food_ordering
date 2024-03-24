# frozen_string_literal: true

module Admin
  class CartsController < ApplicationController
    def edit
      @company_order = CompanyOrder.find_by(status: 'in progress')
      if params[:focus] == 'restaurant'
        @restaurant_order_items = OrderItem.ordered_by_restaurant
        @grouped_order_items_by_restaurant = @restaurant_order_items.group_by do |order_item|
          order_item.product.restaurant
        end

        @restaurant_total_prices = {}
        @grouped_by_product = {}
        @total_quantity = {}
        @total_price = {}
        @order_item_name = {}
        @order_item_unit_price = {}

        @grouped_order_items_by_restaurant.each do |restaurant, order_items|
          @restaurant_total_prices[restaurant] = order_items.map(&:total_price).sum
          @grouped_by_product[restaurant] = order_items.group_by(&:product_id)
          @grouped_by_product[restaurant].each do |product_id, items|
            @total_quantity[product_id] = items.map(&:quantity).sum
            @total_price[product_id] = items.map(&:total_price).sum
            @order_item_name[product_id] = items.first.name
            @order_item_unit_price[product_id] = items.first.unit_price
          end
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
