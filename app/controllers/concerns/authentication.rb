# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern
  included do
    def authentication
      return unless current_user.present?

      redirect_to root_path
    end

    def no_authentication
      return if current_user.present?

      redirect_to root_path
    end
  end
end
