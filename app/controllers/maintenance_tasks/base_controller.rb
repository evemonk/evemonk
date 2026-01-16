# frozen_string_literal: true

module MaintenanceTasks
  class BaseController < ActionController::Base
    include Authentication

    before_action :admin?

    private

    def admin?
      redirect_to root_path if !Current.user.admin?
    end
  end
end
