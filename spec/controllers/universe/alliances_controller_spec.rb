# frozen_string_literal: true

require "rails_helper"

describe Universe::AlliancesController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#index" do
    before do
      #
      # Eve::SearchAlliancesQuery.new(params[:q])
      #                          .query
      #                          .page(params[:page])
      #
      expect(Eve::SearchAlliancesQuery).to receive(:new).with("alliance") do
        double.tap do |a|
          expect(a).to receive(:query) do
            double.tap do |b|
              expect(b).to receive(:page).with("2")
            end
          end
        end
      end
    end

    before { get :index, params: {q: "alliance", page: "2"} }

    it { should respond_with(:ok) }

    it { should render_template(:index) }
  end

  describe "#show" do
    let(:eve_alliance) { instance_double(Eve::Alliance) }

    before do
      #
      # Eve::Alliance.includes(:faction, :creator_corporation, :creator, :executor_corporation)
      #              .find(params[:id])
      #
      expect(Eve::Alliance).to receive(:includes).with(:faction, :creator_corporation, :creator, :executor_corporation) do
        double.tap do |a|
          expect(a).to receive(:find).with("1354830081").and_return(eve_alliance)
        end
      end
    end

    before do
      #
      # Eve::Corporation.where(alliance: @alliance)
      #                 .order(:name)
      #                 .includes(:faction)
      #
      expect(Eve::Corporation).to receive(:where).with(alliance: eve_alliance) do
        double.tap do |a|
          expect(a).to receive(:order).with(:name) do
            double.tap do |b|
              expect(b).to receive(:includes).with(:faction)
            end
          end
        end
      end
    end

    before { get :show, params: {id: "1354830081"} }

    it { should respond_with(:ok) }

    it { should render_template(:show) }
  end
end
