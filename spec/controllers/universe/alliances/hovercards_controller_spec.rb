# frozen_string_literal: true

require "rails_helper"

describe Universe::Alliances::HovercardsController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#show" do
    before do
      #
      # Eve::Alliance.find_by!(alliance_id: params[:alliance_id])
      #              .decorate
      #
      expect(Eve::Alliance).to receive(:find_by!).with(alliance_id: "1354830081") do
        double.tap do |a|
          expect(a).to receive(:decorate)
        end
      end
    end

    before { get :show, params: {alliance_id: "1354830081"} }

    it { should respond_with(:ok) }

    it { should_not render_with_layout }

    it { should render_template(:show) }
  end
end
