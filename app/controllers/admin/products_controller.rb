# frozen_string_literal: true

module Admin
  class ProductsController < ApplicationController
    def index
      @restaurant = Restaurant.find(params[:restaurant_id])
      @products = @restaurant.products
      @order_items = current_order.order_items.new if current_user.present?
    end

    def new
      @restaurant = Restaurant.find(params[:restaurant_id])
      @product = @restaurant.products.new
    end

    def create
      create_product
      if @product.valid?
        redirect_to restaurant_products_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @restaurant = Restaurant.find(params[:restaurant_id])
      @product = @restaurant.products.find(params[:id])
    end

    def update
      @restaurant = Restaurant.find(params[:restaurant_id])
      @product = @restaurant.products.find(params[:id])
      if @product.update(product_params)
        redirect_to restaurant_products_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @restaurant = Restaurant.find(params[:restaurant_id])
      @product = @restaurant.products.find(params[:id])
      @product.destroy
      redirect_to restaurant_products_path
    end

    private

    def create_product
      @restaurant = Restaurant.find(params[:restaurant_id])
      @product = @restaurant.products.create(product_params)
    end

    def product_params
      params.require(:product).permit(:name, :price)
    end
  end
end
