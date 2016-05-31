require 'rails_helper'

describe Api::BaseController do
  it { should be_a ActionController::Base }

  # TODO: spec all this
  #
  # skip_before_action :verify_authenticity_token
  #
  # before_action :authenticate
  #
  # attr_reader :current_user
  #
  # helper_method :parent, :collection, :resource, :current_user
  #
  # def create
  #   build_resource
  #
  #   resource.save!
  # end
  #
  # def update
  #   resource.update!(resource_params)
  # end
  #
  # def destroy
  #   resource.destroy!
  #
  #   head :ok
  # end
  #
  # rescue_from ActionController::ParameterMissing do |exception|
  #   @exception = exception
  #
  #   render :exception, status: :unprocessable_entity
  # end
  #
  # rescue_from ActiveRecord::RecordInvalid, ActiveModel::StrictValidationFailed do
  #   render :errors, status: :unprocessable_entity
  # end
  #
  # rescue_from ActiveRecord::RecordNotFound do |exception|
  #   @exception = exception
  #
  #   render :exception, status: :not_found
  # end
  #
  # private
  #
  # def authenticate
  #   authenticate_or_request_with_http_token do |token, options|
  #     @current_user = User.find_by(token: token)
  #   end
  # end
end
