# frozen_string_literal: true

class FavoriteProductsController < ApplicationController
  def index
    @favorite_products = current_user.products
    @grouped_favorite_products_by_restaurant = @favorite_products.group_by(&:restaurant)
    @order_items = current_order.order_items.new
  end

  def create
    @product = Product.find(params[:product_id])
    current_user.products << @product unless current_user.products.include?(@product)
    @restaurant = @product.restaurant
    redirect_to restaurant_products_path(@restaurant)
  end

  def destroy
    @product = Product.find(params[:id])
    @restaurant = @product.restaurant
    current_user.products.delete(@product)
    redirect_to(params[:redirect] || restaurant_products_path(@restaurant))
  end
end
