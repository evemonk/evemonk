require 'rails_helper'

describe Api::BaseController do
  it { should be_a ActionController::Base }

  it { should_not use_before_action(:verify_authenticity_token) }

  it { should use_before_action(:authenticate) }


  # TODO: spec all this
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


  it { should rescue_from(ActionController::ParameterMissing) }

  it { should rescue_from(ActiveRecord::RecordInvalid) }

  it { should rescue_from(ActiveModel::StrictValidationFailed) }

  it { should rescue_from(ActiveRecord::RecordNotFound) }

  # TODO: spec this
  #
  # private
  #
  # def authenticate
  #   authenticate_or_request_with_http_token do |token, options|
  #     @current_user = User.find_by(token: token)
  #   end
  # end
end
