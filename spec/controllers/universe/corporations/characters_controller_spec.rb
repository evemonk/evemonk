# frozen_string_literal: true

require "rails_helper"

describe Universe::Corporations::CharactersController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#index" do
    let(:eve_corporation) { instance_double(Eve::Corporation) }

    before do
      #
      # Eve::Corporation
      #   .find_by!(corporation_id: params[:corporation_id])
      #
      expect(Eve::Corporation).to receive(:find_by!).with({corporation_id: "1000001"}).and_return(eve_corporation)
    end

    before do
      #
      # Eve::Character
      #   .where(corporation: @corporation)
      #   .order(:name)
      #
      expect(Eve::Character).to receive(:where).with({corporation: eve_corporation}) do
        double.tap do |a|
          expect(a).to receive(:order).with(:name)
        end
      end
    end

    before { get :index, params: {corporation_id: "1000001"} }

    it { should respond_with(:ok) }

    it { should_not render_with_layout }

    it { should render_template(:index) }
  end
end
