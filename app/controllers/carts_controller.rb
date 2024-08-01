# frozen_string_literal: true

class CartsController < ApplicationController
  include Authentication
  
  before_action :no_authentication
  
  def edit
    @order_items = current_order.order_items
  end

  def update
    @company_orders = CompanyOrder.all
    last_order = @company_orders.last
    @company_order = if last_order&.status == 'in progress'
                       last_order
                     else
                       CompanyOrder.create
                     end

    current_order.update(company_order_id: @company_order.id, status: 'confirmed')
    current_order.company_order.save
    session.delete(:personal_order_id)
    redirect_to restaurants_path
  end
end
