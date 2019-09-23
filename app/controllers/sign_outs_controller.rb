# frozen_string_literal: true

class SignOutsController < ApplicationController
  def destroy
    sign_out current_user

    redirect_to root_path
  end
end
