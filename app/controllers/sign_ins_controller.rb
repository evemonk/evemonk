# frozen_string_literal: true

class SignInsController < ApplicationController
  skip_before_action :require_login

  def show
    @form = SignInForm.new(controller: self)
  end

  def create
    @form = SignInForm.new(resource_params.merge(controller: self))

    if @form.save
      redirect_back_or_to characters_path, notice: "Successful signed in!"
    else
      flash[:alert] = "Email and/or password is invalid"
    end
  end

  private

  def resource_params
    params.require(:sign_in)
      .permit(:email, :password, :remember_me)
  end
end
