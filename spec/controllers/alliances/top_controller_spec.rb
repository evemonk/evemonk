# frozen_string_literal: true

require "rails_helper"

RSpec.describe Alliances::TopController do
  it { expect(subject).to be_an(ApplicationController) }

  it { expect(subject).not_to use_before_action(:authenticate_user!) }

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

    it { expect(subject).to respond_with(:ok) }

    it { expect(subject).not_to render_with_layout }
  end
end
