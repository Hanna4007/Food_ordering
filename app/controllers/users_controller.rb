# frozen_string_literal: true

class UsersController < ApplicationController
  include Authentication

  before_action :authentication, only: %i[new create]
  before_action :no_authentication, only: %i[edit update]

  def new
    @user = User.new
  end

  def create
    create_user
    session[:user_id] = @user.id
    if @user.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def create_user
    @user = User.create(user_params)
  end

  def user_params
    params.require(:user).permit(:name, :surname, :phone_number, :password, :password_confirmation)
  end
end
