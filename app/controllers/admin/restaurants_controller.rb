# frozen_string_literal: true

module Admin
  class RestaurantsController < ApplicationController
    include Authentication
    include Admin::Concerns::AdminAuthentication

    before_action :no_authentication
    before_action :check_admin

    def new
      @restaurant = Restaurant.new
    end

    def create
      create_restaurant
      if @restaurant.valid?
        redirect_to root_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @restaurant = Restaurant.find(params[:id])
    end

    def update
      @restaurant = Restaurant.find(params[:id])
      if @restaurant.update(restaurant_params)
        redirect_to root_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @restaurant = Restaurant.find(params[:id])
      @restaurant.destroy
      redirect_to root_path
    end

    private

    def create_restaurant
      @restaurant = Restaurant.create(restaurant_params)
    end

    def restaurant_params
      params.require(:restaurant).permit(:name, :phone_number, :address)
    end
  end
end
