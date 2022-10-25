# frozen_string_literal: true

module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_user!

    before_action :admin?

    private

    def admin?
      redirect_to root_url unless current_user.admin?
    end

    def default_sorting_attribute
      :id
    end

    def default_sorting_direction
      :asc
    end
  end
end
