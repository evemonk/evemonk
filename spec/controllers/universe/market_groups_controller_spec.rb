# frozen_string_literal: true

require "rails_helper"

describe Universe::MarketGroupsController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#index" do
    before do
      #
      # Eve::MarketGroup.main_groups
      #   .includes(:icon)
      #   .order(:name_en)
      #
      expect(Eve::MarketGroup).to receive(:main_groups) do
        double.tap do |a|
          expect(a).to receive(:includes).with(:icon) do
            double.tap do |b|
              expect(b).to receive(:order).with(:name_en)
            end
          end
        end
      end
    end

    before { get :index }

    it { should respond_with(:ok) }

    it { should render_template(:index) }
  end

  describe "#show" do
    let(:eve_market_group) { instance_double(Eve::MarketGroup) }

    before do
      #
      # Eve::MarketGroup.find_by!(market_group_id: params[:id]) # => eve_market_group
      #
      expect(Eve::MarketGroup).to receive(:find_by!).with({market_group_id: "1"})
        .and_return(eve_market_group)
    end

    before do
      #
      # eve_market_group.subgroups.includes(:icon).order(:name_en)
      #
      expect(eve_market_group).to receive(:subgroups) do
        double.tap do |a|
          expect(a).to receive(:includes).with(:icon) do
            double.tap do |b|
              expect(b).to receive(:order).with(:name_en)
            end
          end
        end
      end
    end

    before { get :show, params: {id: "1"} }

    it { should respond_with(:ok) }

    it { should render_template(:show) }
  end
end
