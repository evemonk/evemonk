# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::Eve::ManufacturingItemsController do
  it { expect(subject).to be_a(Api::BaseController) }

  describe "#index" do
    context "with supported content type" do
      before do
        #
        # Eve::SearchManufacturingItemsQuery.new(params[:q])
        #                                   .query
        #                                   .page(params[:page])
        #
        expect(Eve::SearchManufacturingItemsQuery).to receive(:new).with("drake") do
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

      it { expect(subject).to respond_with(:ok) }

      it { expect(subject).to render_template(:index) }
    end

    context "when not supported accept type" do
      before { get :index, params: {format: :html} }

      it { expect(subject).to respond_with(:not_acceptable) }
    end
  end
end
