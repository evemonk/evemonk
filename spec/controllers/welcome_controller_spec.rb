# frozen_string_literal: true

require "rails_helper"

describe WelcomeController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:require_login) }

  describe "#index" do
    before do
      #
      # Eve::Alliance.order(characters_count: :desc).limit(20).decorate
      #
      expect(Eve::Alliance).to receive(:order).with(characters_count: :desc) do
        double.tap do |a|
          expect(a).to receive(:limit).with(20) do
            double.tap do |b|
              expect(b).to receive(:decorate)
            end
          end
        end
      end
    end

    before do
      #
      # Eve::Corporation.order(member_count: :desc).limit(20).decorate
      #
      expect(Eve::Corporation).to receive(:order).with(member_count: :desc) do
        double.tap do |a|
          expect(a).to receive(:limit).with(20) do
            double.tap do |b|
              expect(b).to receive(:decorate)
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
