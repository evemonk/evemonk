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
        # Eve::ServerStatus.last.decorate
        #
        expect(Eve::ServerStatus).to receive(:last) do
          double.tap do |a|
            expect(a).to receive(:decorate)
          end
        end
      end

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
