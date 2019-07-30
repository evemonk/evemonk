# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::AlliancesController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate) }

  describe "#index" do
    context "with supported content type" do
      let(:scoped_eve_alliance) { instance_double(Eve::Alliance) }

      before do
        expect(subject).to receive(:policy_scope).with(::Eve::Alliance)
          .and_return(scoped_eve_alliance)
      end

      before do
        #
        # Eve::AlliancesSearcher.new(params[:q],
        #                            policy_scope(::Eve::Alliance))
        #                       .search
        #                       .page(params[:page])
        #                       .decorate
        #
        expect(Eve::AlliancesSearcher).to receive(:new).with("search string", scoped_eve_alliance) do
          double.tap do |a|
            expect(a).to receive(:search) do
              double.tap do |b|
                expect(b).to receive(:page).with("1") do
                  double.tap do |c|
                    expect(c).to receive(:decorate)
                  end
                end
              end
            end
          end
        end
      end

      before { subject.instance_variable_set(:@_pundit_policy_scoped, true) }

      before { get :index, params: {format: :json, page: "1", q: "search string"} }

      it { should respond_with(:ok) }

      it { should render_template(:index) }
    end

    context "when not supported accept type" do
      before { get :index, params: {format: :html} }

      it { should respond_with(:not_acceptable) }
    end
  end

  describe "#show" do
    context "with supported content type" do
      let(:eve_alliance) { instance_double(Eve::Alliance) }

      before do
        #
        # subject.policy_scope(::Eve::Alliance)
        #        .includes(:faction,
        #                  :creator_corporation,
        #                  :creator,
        #                  :executor_corporation)
        #        .find_by!(corporation_id: params[:id]) # => eve_alliance
        #
        expect(subject).to receive(:policy_scope).with(Eve::Alliance) do
          double.tap do |a|
            expect(a).to receive(:includes).with(:faction,
                                                 :creator_corporation,
                                                 :creator,
                                                 :executor_corporation) do
              double.tap do |b|
                expect(b).to receive(:find_by!).with(alliance_id: "99005443").and_return(eve_alliance)
              end
            end
          end
        end
      end

      before { expect(eve_alliance).to receive(:decorate) }

      before { expect(subject).to receive(:skip_authorization) }

      before { subject.instance_variable_set(:@_pundit_policy_authorized, true) }

      before { get :show, params: {id: "99005443", format: :json} }

      it { should respond_with(:ok) }

      it { should render_template(:show) }
    end

    context "when not supported accept type" do
      before { get :show, params: {id: "99005443", format: :html} }

      it { should respond_with(:not_acceptable) }
    end

    context "when alliance not found" do
      before do
        #
        # subject.policy_scope(::Eve::Alliance)
        #        .includes(:faction,
        #                  :creator_corporation,
        #                  :creator,
        #                  :executor_corporation)
        #        .find_by!(alliance_id: params[:id]) # => ActiveRecord::RecordNotFound
        #
        expect(subject).to receive(:policy_scope).with(Eve::Alliance) do
          double.tap do |a|
            expect(a).to receive(:includes).with(:faction,
                                                 :creator_corporation,
                                                 :creator,
                                                 :executor_corporation) do
              double.tap do |b|
                expect(b).to receive(:find_by!).with(alliance_id: "99005443").and_raise(ActiveRecord::RecordNotFound)
              end
            end
          end
        end
      end

      before { get :show, params: {id: "99005443", format: :json} }

      it { should respond_with(:not_found) }
    end
  end
end
