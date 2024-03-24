# frozen_string_literal: true

class SessionsController < ApplicationController
  include Authentication

  before_action :authentication, only: %i[new create]
  before_action :no_authentication, only: %i[destroy]

  def new; end

  def create
    user_params = params.require(:session)
    user = User.find_by(phone_number: user_params[:phone_number])&.authenticate(user_params[:password])
    if user.present?
      session[:user_id] = user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    session.delete(:personal_order_id)
    session.delete(:user_id)
    redirect_to root_path
  end
end
