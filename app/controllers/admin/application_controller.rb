# frozen_string_literal: true

module Admin
  class ApplicationController < Administrate::ApplicationController
    include Authentication

    before_action :admin?

    private

    def admin?
      redirect_to root_url if !Current.user.admin?
    end

    def default_sorting_attribute
      :id
    end

    def default_sorting_direction
      :asc
    end
  end
end
