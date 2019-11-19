# frozen_string_literal: true

require "rails_helper"

describe WelcomeController do
  it { should be_a(ApplicationController) }

  it { should_not use_before_action(:require_login) }

  describe "#index" do
    before do
      #
      # subject.policy_scope(::Eve::Alliance).order(characters_count: :desc).limit(20).decorate
      #
      expect(subject).to receive(:policy_scope).with(Eve::Alliance) do
        double.tap do |a|
          expect(a).to receive(:order).with(characters_count: :desc) do
            double.tap do |b|
              expect(b).to receive(:limit).with(20) do
                double.tap do |c|
                  expect(c).to receive(:decorate)
                end
              end
            end
          end
        end
      end
    end

    before do
      #
      # subject.policy_scope(::Eve::Corporation).order(member_count: :desc).limit(20).decorate
      #
      expect(subject).to receive(:policy_scope).with(Eve::Corporation) do
        double.tap do |a|
          expect(a).to receive(:order).with(member_count: :desc) do
            double.tap do |b|
              expect(b).to receive(:limit).with(20) do
                double.tap do |c|
                  expect(c).to receive(:decorate)
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
