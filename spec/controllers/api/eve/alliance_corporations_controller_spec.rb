# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::AllianceCorporationsController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate) }

  describe "#index" do
    context "with supported content type" do
      let(:eve_alliance) { instance_double(Eve::Alliance) }

      before do
        #
        # subject.policy_scope(::Eve::Alliance)
        #        .find_by!(alliance_id: params[:alliance_id])
        #        .decorate # => eve_alliance
        #
        expect(subject).to receive(:policy_scope).with(Eve::Alliance) do
          double.tap do |a|
            expect(a).to receive(:find_by!).with(alliance_id: "12345") do
              double.tap do |b|
                expect(b).to receive(:decorate).and_return(eve_alliance)
              end
            end
          end
        end
      end

      before do
        #
        # subject.policy_scope(Eve::Corporation).where(alliance: @alliance)
        #                                       .includes(:alliance,
        #                                                 :ceo,
        #                                                 :creator,
        #                                                 :faction)
        #                                       .page(params[:page])
        #                                       .decorate
        #
        expect(subject).to receive(:policy_scope).with(Eve::Corporation) do
          double.tap do |a|
            expect(a).to receive(:where).with(alliance: eve_alliance) do
              double.tap do |b|
                expect(b).to receive(:includes).with(:alliance, :ceo, :creator, :faction) do
                  double.tap do |c|
                    expect(c).to receive(:page).with("1") do
                      double.tap do |d|
                        expect(d).to receive(:decorate)
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end

      before { subject.instance_variable_set(:@_pundit_policy_scoped, true) }

      before { get :index, params: {format: :json, page: "1", alliance_id: "12345"} }

      it { should respond_with(:ok) }

      it { should render_template(:index) }
    end

    context "when not supported accept type" do
      before { get :index, params: {alliance_id: "12345", format: :html} }

      it { should respond_with(:not_acceptable) }
    end

    context "when alliance not found" do
      before do
        #
        # subject.policy_scope(::Eve::Alliance)
        #        .find_by!(alliance_id: params[:alliance_id])
        #
        expect(subject).to receive(:policy_scope).with(Eve::Alliance) do
          double.tap do |a|
            expect(a).to receive(:find_by!).with(alliance_id: "12345")
              .and_raise(ActiveRecord::RecordNotFound)
          end
        end
      end

      before { get :index, params: {alliance_id: "12345", format: :json} }

      it { should respond_with(:not_found) }
    end
  end
end
