# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::Alliances::CorporationsController do
  it { expect(subject).to be_an(ApplicationController) }

  it { expect(subject).not_to use_before_action(:authenticate_user!) }

  describe "#index" do
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

    it { expect(subject).to respond_with(:ok) }

    it { expect(subject).not_to render_with_layout }

    it { expect(subject).to render_template(:index) }
  end
end
