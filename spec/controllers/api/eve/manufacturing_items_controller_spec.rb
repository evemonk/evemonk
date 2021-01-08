# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::ManufacturingItemsController do
  it { should be_a(Api::BaseController) }

  describe "#index" do
    context "with supported content type" do
      before do
        #
        # Eve::ManufacturingItemsSearcher.new(params[:q])
        #                                .search
        #                                .page(params[:page])
        #                                .decorate
        #
        expect(Eve::ManufacturingItemsSearcher).to receive(:new).with("drake") do
          double.tap do |a|
            expect(a).to receive(:search) do
              double.tap do |b|
                expect(b).to receive(:page).with("1") do
                  double.tap do |c|
                    expect(c).to receive(:decorate)
                  end
                end
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
