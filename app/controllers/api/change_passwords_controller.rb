# frozen_string_literal: true

module Api
  class ChangePasswordsController < BaseController
    def create
      @form = ChangePasswordForm.new(change_password_params.merge(user: current_user))

      skip_authorization

      if @form.save
        render :create
      else
        render :errors, status: :unprocessable_entity
      end
    end

    private

    def change_password_params
      params.require(:change_password)
        .permit(:old_password, :password, :password_confirmation, :name,
          :device_type, :device_token)
    end
  end
end
