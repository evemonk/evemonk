require 'rails_helper'

describe Api::BaseController do
  it { should be_a(ApplicationController) }

  it { should be_a(Pundit) }

  it { should use_before_action(:authenticate) }

  pending { should use_after_action(:verify_authorized).except(:index) }

  pending { should use_after_action(:verify_policy_scoped).only(:index) }

  describe '#show' do
    let(:resource) { double }

    before { expect(subject).to receive(:resource).and_return(resource) }

    before { expect(subject).to receive(:authorize).with(resource) }

    specify { expect { subject.show }.not_to raise_error }
  end

  describe '#create' do
    let(:resource) { double }

    before { expect(subject).to receive(:build_resource) }

    before { expect(subject).to receive(:resource).and_return(resource).twice }

    before { expect(subject).to receive(:authorize).with(resource) }

    before { expect(resource).to receive(:save!) }

    specify { expect { subject.create }.not_to raise_error }
  end

  describe '#update' do
    let(:resource) { double }

    let(:resource_params) { double }

    before { expect(subject).to receive(:resource).and_return(resource).twice }

    before { expect(subject).to receive(:authorize).with(resource) }

    before { expect(subject).to receive(:resource_params).and_return(resource_params) }

    before { expect(resource).to receive(:update!).with(resource_params) }

    specify { expect { subject.update }.not_to raise_error }
  end

  describe '#destroy' do
    let(:resource) { double }

    before { expect(subject).to receive(:resource).and_return(resource).twice }

    before { expect(subject).to receive(:authorize).with(resource) }

    before { expect(resource).to receive(:destroy!) }

    before { expect(subject).to receive(:head).with(:ok) }

    specify { expect { subject.destroy }.not_to raise_error }
  end

  it { should rescue_from(ActionController::ParameterMissing) }

  it { should rescue_from(ActiveRecord::RecordInvalid) }

  it { should rescue_from(ActiveModel::StrictValidationFailed) }

  it { should rescue_from(ActiveRecord::RecordNotFound) }

  it { should rescue_from(Pundit::NotAuthorizedError) }

  describe '#authenticate' do
    let(:session) { create(:session) }

    let(:options) { double }

    before { expect(subject).to receive(:authenticate_or_request_with_http_token).and_yield(session.token, options) }

    before do
      #
      # Session.find_by(token: token)
      #
      expect(Session).to receive(:find_by).with(token: session.token).and_call_original
    end

    its(:authenticate) { should eq(session) }
  end

  describe '#current_user' do
    context '@current_user is already set' do
      let(:user) { double }

      before { subject.instance_variable_set(:@current_user, user) }

      specify { expect(subject.send(:current_user)).to eq(user) }
    end

    context '@current_user is not yet set' do
      let(:user) { double }

      before do
        #
        # subject.session.user
        #
        expect(subject).to receive(:session) do
          double.tap do |a|
            expect(a).to receive(:user).and_return(user)
          end
        end
      end

      specify { expect(subject.send(:current_user)).to eq(user) }
    end
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
