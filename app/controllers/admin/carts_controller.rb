# frozen_string_literal: true

module Admin
  class CartsController < ApplicationController
    def edit
      @company_order = CompanyOrder.find_by(status: 'in progress')
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
