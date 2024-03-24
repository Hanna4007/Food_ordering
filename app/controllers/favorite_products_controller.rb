# frozen_string_literal: true

class FavoriteProductsController < ApplicationController
  # додати перевірку щоб current_user був
  def index
    @favorite_products = current_user.products
    @grouped_favorite_products_by_restaurant = @favorite_products.group_by(&:restaurant)
    @order_items = current_order.order_items.new
  end

  def create
    @product = Product.find(params[:product_id])
    current_user.products << @product unless current_user.products.include?(@product)
  end

  def destroy
    @product = Product.find(params[:id])
    current_user.products.delete(@product)
    redirect_to favorite_products_path
  end
end
