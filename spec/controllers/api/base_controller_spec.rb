require 'rails_helper'

describe Api::BaseController do
  it { should be_a ActionController::Base }

  it { should be_a Pundit }

  it { should_not use_before_action(:verify_authenticity_token) }

  it { should use_before_action(:authenticate) }

  pending { should use_after_action(:verify_authorized).except(:index) }

  pending { should use_after_action(:verify_policy_scoped).only(:index) }

  # TODO: spec all this
  #
  # attr_reader :current_user
  #
  # helper_method :parent, :collection, :resource, :current_user
  #
  # def show
  #   authorize(resource)
  # end
  #
  # def create
  #   build_resource
  #
  #   authorize(resource)
  #
  #   resource.save!
  # end
  #
  # def update
  #   authorize(resource)
  #
  #   resource.update!(resource_params)
  # end
  #
  # def destroy
  #   authorize(resource)
  #
  #   resource.destroy!
  #
  #   head :ok
  # end

  it { should rescue_from(ActionController::ParameterMissing) }

  it { should rescue_from(ActiveRecord::RecordInvalid) }

  it { should rescue_from(ActiveModel::StrictValidationFailed) }

  it { should rescue_from(ActiveRecord::RecordNotFound) }

  describe '#authenticate' do
    let(:user) { double }

    let(:token) { double }

    let(:options) { double }

    before { expect(subject).to receive(:authenticate_or_request_with_http_token).and_yield(token, options) }

    before do
      #
      # User.find_by(token: token)
      #
      expect(User).to receive(:find_by).with(token: token).and_return(user)
    end

    its(:authenticate) { should eq(user) }
  end

  describe '#resource' do
    specify { expect { subject.send(:resource) }.to raise_error(NotImplementedError) }
  end

  describe '#resource_params' do
    specify { expect { subject.send(:resource_params) }.to raise_error(NotImplementedError) }
  end

  describe '#build_resource' do
    specify { expect { subject.send(:build_resource) }.to raise_error(NotImplementedError) }
  end

  describe '#collection' do
    specify { expect { subject.send(:collection) }.to raise_error(NotImplementedError) }
  end
end
