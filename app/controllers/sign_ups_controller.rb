# frozen_string_literal: true

class SignUpsController < ApplicationController
  def show
    @service = SignUpService.new
  end

  def create
    @service = SignUpService.new(resource_params)

    if @service.save
      redirect_to characters_path
    else
      render :show
    end
  end

  private

  def resource_params
    params.require(:sign_up)
      .permit(:email, :password, :password_confirmation)
  end
end
