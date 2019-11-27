# frozen_string_literal: true

class SignUpsController < ApplicationController
  skip_before_action :require_login

  def show
    @form = SignUpForm.new(controller: self)
  end

  def create
    @form = SignUpForm.new(resource_params.merge(controller: self))

    if @form.save
      redirect_back_or_to characters_path, notice: "Successful signed up!"
    else
      render :show
    end
  end

  private

  def resource_params
    params.require(:sign_up)
      .permit(:email, :password, :password_confirmation, :remember_me)
  end
end
