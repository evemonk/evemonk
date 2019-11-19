# frozen_string_literal: true

class SignOutsController < ApplicationController
  def destroy
    logout

    redirect_to root_path, notice: "Logged out!"
  end
end
