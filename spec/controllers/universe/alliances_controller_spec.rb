# frozen_string_literal: true

require "rails_helper"

describe Universe::AlliancesController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#index" do
    let(:collection) { double }

    before do
      #
      # Eve::SearchAlliancesQuery.new(params[:q])
      #                          .query # => collection
      #
      expect(Eve::SearchAlliancesQuery).to receive(:new).with("alliance") do
        double.tap do |a|
          expect(a).to receive(:query).and_return(collection)
        end
      end
    end

    before { expect(subject).to receive(:pagy).with(collection) }

    before { get :index, params: {q: "alliance"} }

    it { should respond_with(:ok) }

    it { should render_template(:index) }
  end

  describe "#show" do
    let(:eve_alliance) { instance_double(Eve::Alliance) }

    before do
      #
      # Eve::Alliance.includes(:faction, :creator_corporation, :creator, :executor_corporation)
      #              .find_by!(alliance_id: params[:id])
      #
      expect(Eve::Alliance).to receive(:includes).with(:faction, :creator_corporation, :creator, :executor_corporation) do
        double.tap do |a|
          expect(a).to receive(:find_by!).with(alliance_id: "1354830081").and_return(eve_alliance)
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
