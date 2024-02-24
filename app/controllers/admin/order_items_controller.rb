# frozen_string_literal: true

module Admin
  class OrderItemsController < ApplicationController
    def update
      @personal_order = PersonalOrder.find(params[:personal_order_id])
      @order_item = @personal_order.order_items.find(params[:id])

      if @order_item.update(order_item_params)
        @personal_order.save
        @personal_order.company_order.save
        redirect_to edit_admin_carts_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @personal_order = PersonalOrder.find(params[:personal_order_id])
      @order_item = @personal_order.order_items.find(params[:id])
      @order_item.destroy
      @personal_order.save
      @personal_order.company_order.save
      redirect_to edit_admin_carts_path, status: :see_other
    end

    private

    def order_item_params
      params.require(:order_item).permit(:quantity)
    end
  end
end
