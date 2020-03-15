# frozen_string_literal: true

class AuthyController < ApplicationController
  def new
  end

  def show
  end

  def update
    if current_user.update!(resource_params)
      authy = Authy::API.register_user(
        email: current_user.email,
        cellphone: current_user.phone_number,
        country_code: current_user.country_code
      )
      current_user.update!(authy_id: authy.id)

      redirect_to :show
    end
  end

  private

  def resource_params
    params.require(:user).permit(:phone_number, :country_code)
  end
end
