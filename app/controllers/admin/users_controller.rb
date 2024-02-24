# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    include Admin::Concerns::AdminAuthentication

    before_action :check_admin

    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
    end

    def new
      @user = User.new
    end

    def create
      create_user
      if @user.valid?
        redirect_to admin_users_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to admin_users_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_path, status: :see_other
    end

    private

    def create_user
      @user = User.create(user_params)
    end

    def user_params
      params.require(:user).permit(:name, :surname, :phone_number, :status)
    end
  end
end
