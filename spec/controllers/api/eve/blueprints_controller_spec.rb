# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::BlueprintsController do
  it { should be_a(Api::BaseController) }

  describe "#index" do
    context "with supported content type" do
      before do
        #
        # Eve::SearchBlueprintsQuery.new(params[:q])
        #                           .query
        #                           .page(params[:page])
        #
        expect(Eve::SearchBlueprintsQuery).to receive(:new).with("drake") do
          double.tap do |a|
            expect(a).to receive(:query) do
              double.tap do |b|
                expect(b).to receive(:page).with("1")
              end
            end
          end
        end
      end

      before { get :index, params: {format: :json, page: "1", q: "drake"} }

      it { should respond_with(:ok) }

      it { should render_template(:index) }
    end

    context "when not supported accept type" do
      before { get :index, params: {format: :html} }

      it { should respond_with(:not_acceptable) }
    end
  end
end
