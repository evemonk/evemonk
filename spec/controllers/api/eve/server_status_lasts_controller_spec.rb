# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::ServerStatusLastsController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate) }

  describe "#show" do
    context "with supported content type" do
      let(:eve_server_status) { instance_double(Eve::ServerStatus) }

      before do
        #
        # subject.policy_scope(::Eve::ServerStatus)
        #        .last # => eve_server_status
        #
        expect(subject).to receive(:policy_scope).with(Eve::ServerStatus) do
          double.tap do |a|
            expect(a).to receive(:last).and_return(eve_server_status)
          end
        end
      end

      before { expect(eve_server_status).to receive(:decorate) }

      before { subject.instance_variable_set(:@_pundit_policy_authorized, true) }

      before { get :show, params: {format: :json} }

      it { should respond_with(:ok) }

      it { should render_template(:show) }
    end

    context "when not supported accept type" do
      before { get :show, params: {format: :html} }

      it { should respond_with(:not_acceptable) }
    end
  end
end
