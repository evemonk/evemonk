# frozen_string_literal: true

module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_user!

    before_action :admin?

    private

    def admin?
      redirect_to root_url unless current_user.admin?
    end

    def valid_action?(name, resource = resource_class)
      ["new", "edit", "destroy"].exclude?(name.to_s) && super
    end
  end
end
