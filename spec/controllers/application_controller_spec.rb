# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationController do
  it { is_expected.to use_before_action(:authenticate_user!) }

  it { is_expected.to use_before_action(:default_locale) }

  it { is_expected.to use_before_action(:current_user_locale) }

  # private methods

  describe "#after_sign_in_path_for" do
    let(:resource) { double }

    specify { expect(subject.send(:after_sign_in_path_for, resource)).to eq("/characters") }
  end

  describe "#default_locale" do
    before { expect(I18n).to receive(:locale=).with(:en) }

    specify { expect { subject.send(:default_locale) }.not_to raise_error }
  end

  describe "#current_user_locale" do
    context "when user not logged in" do
      before { expect(subject).to receive(:current_user).and_return(nil) }

      before { expect(I18n).not_to receive(:locale=) }

      specify { expect { subject.send(:current_user_locale) }.not_to raise_error }
    end

    context "when user logged in" do
      context "when user locale is auto detect" do
        let(:user) { build(:user, locale: :auto_detect) }

        before { expect(subject).to receive(:current_user).and_return(user).twice }

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
        let(:user) { build(:user, locale: :english) }

        before { expect(subject).to receive(:current_user).and_return(user).exactly(3).times }

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
