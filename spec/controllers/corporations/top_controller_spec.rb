# frozen_string_literal: true

require "rails_helper"

describe Corporations::TopController do
  it { should be_an(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#index" do
    before do
      #
      # Eve::Corporation.not_npc.order(member_count: :desc).limit(20)
      #
      expect(Eve::Corporation).to receive(:not_npc) do
        double.tap do |a|
          expect(a).to receive(:order).with({member_count: :desc}) do
            double.tap do |b|
              expect(b).to receive(:limit).with(20)
            end
          end
        end
      end
    end

    before { get :index }

    it { should respond_with(:ok) }

    it { should render_template(:index) }
  end
end
