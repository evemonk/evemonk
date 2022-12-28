# frozen_string_literal: true

require "rails_helper"

describe WelcomeController do
  it { should be_an(ApplicationController) }

  it { should_not use_before_action(:authenticate_user!) }

  describe "#index" do
    before do
      #
      # Eve::Alliance.order(characters_count: :desc).limit(20).load_async
      #
      expect(Eve::Alliance).to receive(:order).with({characters_count: :desc}) do
        double.tap do |a|
          expect(a).to receive(:limit).with(20) do
            double.tap do |b|
              expect(b).to receive(:load_async)
            end
          end
        end
      end
    end

    before do
      #
      # Eve::Corporation.not_npc.order(member_count: :desc).limit(20).load_async
      #
      expect(Eve::Corporation).to receive(:not_npc) do
        double.tap do |a|
          expect(a).to receive(:order).with({member_count: :desc}) do
            double.tap do |b|
              expect(b).to receive(:limit).with(20) do
                double.tap do |c|
                  expect(c).to receive(:load_async)
                end
              end
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
