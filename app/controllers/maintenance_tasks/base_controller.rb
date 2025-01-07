# frozen_string_literal: true

module MaintenanceTasks
  class BaseController < ActionController::Base
    before_action :authenticate_user!

    before_action :admin?

    private

    def admin?
      redirect_to "/" if !current_user.admin?
    end
  end
end
