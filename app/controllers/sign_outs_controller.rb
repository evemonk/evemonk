# frozen_string_literal: true

class SignOutsController < ApplicationController
  def destroy
    logout

    skip_authorization

    redirect_to root_path
  end
end
