# frozen_string_literal: true

module Admin
  module Concerns
    module AdminAuthentication
      extend ActiveSupport::Concern
      included do
        def check_admin
          return if current_user.status?

          redirect_to root_path
        end
      end
    end
  end
end
