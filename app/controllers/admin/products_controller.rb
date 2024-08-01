# frozen_string_literal: true

module Admin
  class ProductsController < ApplicationController
    include Authentication
    include Admin::Concerns::AdminAuthentication

    before_action :no_authentication
    before_action :check_admin

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

      @company_order = CompanyOrder.find_by(status: 'in progress') 
      if @company_order.present?       
        @personal_orders = @company_order.personal_orders
        @personal_orders.each do |personal_order|
          personal_order.order_items.where(product_id: @product.id).destroy_all
          personal_order.save
        end
        @company_order.save
      end

      @company_order = CompanyOrder.find_by(status: 'confirmed')  
      if @company_order.present?    
        @personal_orders = @company_order.personal_orders
        @personal_orders.each do |personal_order|
          personal_order.order_items.where(product_id: @product.id).each do |order_item|
            order_item.update(product_id: 5)
          end
        end
      end
        
      @product.destroy
      redirect_to restaurant_products_path(@restaurant)
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
