# frozen_string_literal: true

require "rails_helper"

RSpec.describe MailsController, type: :controller do
  it { expect(subject).to be_an(ApplicationController) }

  it { expect(subject).to use_before_action(:authenticate_user!) }

  describe "#index" do
    context "when user signed in" do
      let(:user) { create(:user) }

      before { sign_in(user) }

      before { expect(subject).to receive(:current_user_locale) }

      let(:character) { instance_double(Character) }

      before do
        #
        # subject.current_user
        #        .characters
        #        .includes(:alliance, :corporation)
        #        .find_by!(character_id: params[:character_id])
        #
        expect(subject).to receive(:current_user) do
          double.tap do |a|
            expect(a).to receive(:characters) do
              double.tap do |b|
                expect(b).to receive(:includes).with(:alliance, :corporation) do
                  double.tap do |c|
                    expect(c).to receive(:find_by!).with(character_id: "1").and_return(character)
                  end
                end
              end
            end
          end
        end
      end

      before do
        #
        # character.character_mail_labels
        #
        expect(character).to receive(:character_mail_labels)
      end

      before { get :index, params: {character_id: "1"} }

      it { expect(subject).to respond_with(:ok) }

      it { expect(subject).to render_template(:index) }
    end

    context "when user not signed in" do
      before { get :index, params: {character_id: "1"} }

      it { expect(subject).to redirect_to(new_user_session_path) }
    end
  end
end
