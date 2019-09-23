# frozen_string_literal: true

class SignInsController < ApplicationController
  skip_before_action :require_login

  def show
    @service = SignInService.new

    skip_authorization
  end

  def create
    @service = SignInService.new(resource_params)

    if @service.save
      redirect_to characters_path
    else
      render :show
    end
  end

  private

  def resource_params
    params.require(:sign_in)
          .permit(:email, :password)
  end
end
