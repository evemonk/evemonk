# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::CharacterCorporationsHistoryController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate) }

  describe "#index" do
    context "with supported content type" do
      let(:eve_character) { instance_double(Eve::Character) }

      before do
        #
        # subject.policy_scope(::Eve::Character)
        #        .find_by!(character_id: params[:character_id])
        #        .decorate # => eve_character
        #
        expect(subject).to receive(:policy_scope).with(Eve::Character) do
          double.tap do |a|
            expect(a).to receive(:find_by!).with(character_id: "99005443") do
              double.tap do |b|
                expect(b).to receive(:decorate).and_return(eve_character)
              end
            end
          end
        end
      end

      before do
        #
        # subject.policy_scope(::Eve::CharacterCorporationHistory)
        #        .includes(:corporation)
        #        .where(character: character)
        #        .order(record_id: :desc)
        #        .page(params[:page])
        #        .decorate
        #
        expect(subject).to receive(:policy_scope).with(Eve::CharacterCorporationHistory) do
          double.tap do |a|
            expect(a).to receive(:includes).with(:corporation) do
              double.tap do |b|
                expect(b).to receive(:where).with(character: eve_character) do
                  double.tap do |c|
                    expect(c).to receive(:order).with(record_id: :desc) do
                      double.tap do |d|
                        expect(d).to receive(:page).with("1") do
                          double.tap do |e|
                            expect(e).to receive(:decorate)
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end

      before { get :index, params: {character_id: "99005443", page: "1", format: :json} }

      it { should respond_with(:ok) }

      it { should render_template(:index) }
    end

    context "when not supported accept type" do
      before { get :index, params: {character_id: "99005443", format: :html} }

      it { should respond_with(:not_acceptable) }
    end

    context "when character not found" do
      before do
        #
        # subject.policy_scope(::Eve::Character)
        #        .find_by!(character_id: params[:character_id]) # => ActiveRecord::RecordNotFound
        #
        expect(subject).to receive(:policy_scope).with(Eve::Character) do
          double.tap do |a|
            expect(a).to receive(:find_by!).with(character_id: "99005443")
              .and_raise(ActiveRecord::RecordNotFound)
          end
        end
      end

      before { get :index, params: {character_id: "99005443", format: :json} }

      it { should respond_with(:not_found) }
    end
  end
end
