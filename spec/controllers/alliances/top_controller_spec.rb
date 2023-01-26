# frozen_string_literal: true

require "rails_helper"

describe Alliances::TopController do
  it { should be_an(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#index" do
    before do
      #
      # Eve::Alliance.order(characters_count: :desc).limit(20)
      #
      expect(Eve::Alliance).to receive(:order).with(characters_count: :desc) do
        double.tap do |a|
          expect(a).to receive(:limit).with(20)
        end
      end
    end

    before { get :index }

    it { should respond_with(:ok) }

    it { should_not render_with_layout }

    it { should render_template(:index) }
  end
end
