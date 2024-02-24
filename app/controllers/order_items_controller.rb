# frozen_string_literal: true

class OrderItemsController < ApplicationController
  include Authentication

  before_action :no_authentication

  def create
    @order_item = current_order.order_items.new(order_item_params)
    @order_item.save
    session[:personal_order_id] = current_order.id
    current_order.save
  end

  def edit
    @order_item = current_order.order_items.find(params[:id])
  end

  def update
    @order_item = current_order.order_items.find(params[:id])
    @order_item.update(order_item_params)
    current_order.save
    redirect_to edit_carts_path
  end

  def destroy
    @order_item = current_order.order_items.find(params[:id])
    @order_item.destroy
    current_order.save
    redirect_to edit_carts_path, status: :see_other
  end

  private

  def order_item_params
    params.require(:order_item).permit(:product_id, :name, :unit_price, :total_price, :quantity)
  end
end
