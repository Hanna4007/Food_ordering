# frozen_string_literal: true

module Admin
  class CompanyOrdersController < ApplicationController
    def index
      @company_orders = CompanyOrder.company_order_desc
    end

    def show
      @company_order = CompanyOrder.find(params[:id])
      return unless @company_order.status == 'in progress'

      redirect_to edit_admin_carts_path
    end

    def edit
      @company_order = CompanyOrder.find(params[:id])
    end

    def update
      @company_order = CompanyOrder.find(params[:id])
      @company_order.update(status: 'confirmed')
      redirect_to restaurants_path
    end

    private

    def company_order_params
      params.reqiure(:company_order).permit(:status, :company_price)
    end
  end
end
