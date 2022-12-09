# frozen_string_literal: true

require "rails_helper"

describe Universe::Alliances::CorporationsController do
  it { should be_an(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#index" do
    # before do
    #   #
    #   # Eve::Alliance.find_by!(alliance_id: params[:alliance_id])
    #   #
    #   expect(Eve::Alliance).to receive(:find_by!).with(alliance_id: "1354830081")
    # end

    let(:eve_alliance) { instance_double(Eve::Alliance) }

    before do
      #
      # Eve::Alliance.find(params[:alliance_id])
      #
      expect(Eve::Alliance).to receive(:find).with("1354830081").and_return(eve_alliance)
    end

    before do
      #
      # Eve::Corporation.where(alliance: @alliance)
      #                 .order(:name)
      #
      expect(Eve::Corporation).to receive(:where).with(alliance: eve_alliance) do
        double.tap do |a|
          expect(a).to receive(:order).with(:name)
        end
      end
    end

    before { get :index, params: {alliance_id: "1354830081"} }

    it { should respond_with(:ok) }

    it { should_not render_with_layout }

    it { should render_template(:index) }
  end
end
