# frozen_string_literal: true

class SignUpsController < ApplicationController
  skip_before_action :require_login

  def show
    @service = SignUpForm.new
  end

  def create
    @service = SignUpForm.new(resource_params)

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
