# frozen_string_literal: true

class PersonalOrdersController < ApplicationController
  def index
    @personal_orders = current_user.personal_orders.personal_order_desc
  end

  def show
    @personal_order = current_user.personal_orders.find(params[:id])
  end

  private

  def personal_order_params
    params.require(:personal_order).permit(:total_price)
  end
end
