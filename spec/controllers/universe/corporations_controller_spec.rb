# frozen_string_literal: true

require "rails_helper"

describe Universe::CorporationsController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#index" do
    before do
      #
      # Eve::SearchCorporationsQuery.new(params[:q])
      #                             .query
      #                             .page(params[:page])
      #
      expect(Eve::SearchCorporationsQuery).to receive(:new).with("corporation") do
        double.tap do |a|
          expect(a).to receive(:query) do
            double.tap do |b|
              expect(b).to receive(:page).with("2")
            end
          end
        end
      end
    end

    before { get :index, params: {q: "corporation", page: "2"} }

    it { should respond_with(:ok) }

    it { should render_template(:index) }
  end

  describe "#show" do
    before do
      #
      # Eve::Corporation
      #   .find_by!(corporation_id: params[:id])
      #
      expect(Eve::Corporation).to receive(:find_by!).with({corporation_id: "1000001"})
    end

    before { get :show, params: {id: "1000001"} }

    it { should respond_with(:ok) }

    it { should render_template(:show) }
  end
end
