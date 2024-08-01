# frozen_string_literal: true

class PersonalOrdersController < ApplicationController
  include Authentication
  
  before_action :no_authentication

  def index
    @personal_orders = current_user.personal_orders.personal_order_desc
  end

  def show
    @personal_order = current_user.personal_orders.find(params[:id])
  end
end
