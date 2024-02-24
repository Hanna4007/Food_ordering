# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, :current_order

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  def current_order
    @current_order ||= (session[:personal_order_id].nil? ? session_personal_order_id_absent : session_personal_order_id_present)
  end

  def session_personal_order_id_absent
    last_order = current_user.personal_orders.last
    last_order&.status == 'in progress' ? last_order : current_user.personal_orders.new
  end

  def session_personal_order_id_present
    current_user.personal_orders.find_by(id: session[:personal_order_id]) || current_user.personal_orders.new
  end
end
