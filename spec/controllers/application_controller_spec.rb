# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  it { expect(subject).to be_an(Authentication) }

  it { expect(subject).to be_a(Pundit::Authorization) }

  it { expect(subject).to use_before_action(:require_authentication) }

  it { expect(subject).to use_before_action(:default_locale) }

  it { expect(subject).to use_before_action(:current_user_locale) }

  # private methods

  describe "#pundit_user" do
    context "when user is not logged in" do
      before { Current.session = nil }

      specify { expect(subject.send(:pundit_user)).to eq(nil) }
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { Current.session = user.sessions.create! }

      specify { expect(subject.send(:pundit_user)).to eq(user) }
    end
  end

  describe "#default_locale" do
    before { expect(I18n).to receive(:locale=).with(:en) }

    specify { expect { subject.send(:default_locale) }.not_to raise_error }
  end

  describe "#current_user_locale" do
    context "when user is not logged in" do
      before { Current.session = nil }

      before { expect(I18n).not_to receive(:locale=) }

      specify { expect { subject.send(:current_user_locale) }.not_to raise_error }
    end

    context "when user is logged in" do
      context "when user locale is auto detect" do
        let(:user) { create(:user, locale: :auto_detect) }

        before { Current.session = user.sessions.create! }

        let(:available_locales) { double }

        let(:locale) { double }

        before do
          #
          # I18n.available_locales # => available_locales
          #
          expect(I18n).to receive(:available_locales).and_return(available_locales)
        end

        before do
          #
          # http_accept_language.compatible_language_from(I18n.available_locales)
          #
          expect(subject).to receive(:http_accept_language) do
            double.tap do |a|
              expect(a).to receive(:compatible_language_from).with(available_locales).and_return(locale)
            end
          end
        end

        before { expect(I18n).to receive(:locale=).with(locale) }

        specify { expect { subject.send(:current_user_locale) }.not_to raise_error }
      end

      context "when user locale is set" do
        let(:user) { create(:user, locale: :english) }

        before { Current.session = user.sessions.create! }

        let(:locale) { double }

        before do
          #
          # UserLocale.new(current_user.locale).to_locale # => locale
          #
          expect(UserLocale).to receive(:new).with("english") do
            double.tap do |a|
              expect(a).to receive(:to_locale).and_return(locale)
            end
          end
        end

        before { expect(I18n).to receive(:locale=).with(locale) }

        specify { expect { subject.send(:current_user_locale) }.not_to raise_error }
      end
    end
  end
end
