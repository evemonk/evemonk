# frozen_string_literal: true

require "rails_helper"

describe EveOnlineCallbackService do
  let(:user) { instance_double(User) }

  let(:request) { double }

  subject { described_class.new(user, request) }

  describe "#initialize" do
    its(:user) { should eq(user) }

    its(:request) { should eq(request) }
  end

  describe "#save!" do
    before { expect(subject).to receive(:assign_character_attributes) }

    before { expect(subject).to receive(:remove_old_characters) }

    let(:character) { instance_double(Character) }

    before { expect(subject).to receive(:character).and_return(character) }

    before { expect(character).to receive(:save!) }

    before { expect(subject).to receive(:update_character_info) }

    before { expect(subject).to receive(:import_missing_data) }

    before { expect(subject).not_to receive(:import_corporation_members) }

    specify { expect { subject.save! }.not_to raise_error }
  end

  # private methods

  describe "#character_id" do
    before do
      #
      # request.env.dig("omniauth.auth", "info", "character_id")
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with("omniauth.auth", "info", "character_id")
        end
      end
    end

    specify { expect { subject.send(:character_id) }.not_to raise_error }
  end

  describe "#name" do
    before do
      #
      # request.env.dig("omniauth.auth", "info", "name")
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with("omniauth.auth", "info", "name")
        end
      end
    end

    specify { expect { subject.send(:name) }.not_to raise_error }
  end

  describe "#access_token" do
    before do
      #
      # request.env.dig("omniauth.auth", "credentials", "token")
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with("omniauth.auth", "credentials", "token")
        end
      end
    end

    specify { expect { subject.send(:access_token) }.not_to raise_error }
  end

  describe "#refresh_token" do
    before do
      #
      # request.env.dig("omniauth.auth", "credentials", "refresh_token")
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with("omniauth.auth", "credentials", "refresh_token")
        end
      end
    end

    specify { expect { subject.send(:refresh_token) }.not_to raise_error }
  end

  describe "#token_expires_at" do
    let(:expires_at) { double }

    before do
      #
      # request.env.dig("omniauth.auth", "credentials", "expires_at")
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with("omniauth.auth", "credentials", "expires_at")
            .and_return(expires_at)
        end
      end
    end

    before do
      #
      # Time.zone.at(expires_at)
      #
      expect(Time).to receive(:zone) do
        double.tap do |a|
          expect(a).to receive(:at).with(expires_at)
        end
      end
    end

    specify { expect { subject.send(:token_expires_at) }.not_to raise_error }
  end

  describe "#token_expires" do
    before do
      #
      # request.env.dig("omniauth.auth", "credentials", "expires")
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with("omniauth.auth", "credentials", "expires")
        end
      end
    end

    specify { expect { subject.send(:token_expires) }.not_to raise_error }
  end

  describe "#scopes" do
    before do
      #
      # request.env.dig("omniauth.auth", "info", "scopes")
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with("omniauth.auth", "info", "scopes")
        end
      end
    end

    specify { expect { subject.send(:scopes) }.not_to raise_error }
  end

  describe "#token_type" do
    before do
      #
      # request.env.dig("omniauth.auth", "info", "token_type")
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with("omniauth.auth", "info", "token_type")
        end
      end
    end

    specify { expect { subject.send(:token_type) }.not_to raise_error }
  end

  describe "#character_owner_hash" do
    before do
      #
      # request.env.dig("omniauth.auth", "info", "character_owner_hash")
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with("omniauth.auth", "info", "character_owner_hash")
        end
      end
    end

    specify { expect { subject.send(:character_owner_hash) }.not_to raise_error }
  end

  describe "#character" do
    context "when @character is set" do
      let(:character) { instance_double(Character) }

      before { subject.instance_variable_set(:@character, character) }

      specify { expect(subject.send(:character)).to eq(character) }
    end

    context "when @character not set" do
      let(:character) { instance_double(Character) }

      let(:character_owner_hash) { double }

      before { expect(subject).to receive(:character_owner_hash).and_return(character_owner_hash) }

      before do
        #
        # user.characters.find_or_initialize_by(character_owner_hash: character_owner_hash) # => character
        #
        expect(user).to receive(:characters) do
          double.tap do |a|
            expect(a).to receive(:find_or_initialize_by).with(character_owner_hash: character_owner_hash).and_return(character)
          end
        end
      end

      specify { expect(subject.send(:character)).to eq(character) }

      specify { expect { subject.send(:character) }.to change { subject.instance_variable_get(:@character) }.from(nil).to(character) }
    end
  end

  describe "#assign_character_attributes" do
    let(:character) { instance_double(Character) }

    let(:name) { double }

    let(:access_token) { double }

    let(:refresh_token) { double }

    let(:token_expires_at) { double }

    let(:token_expires) { double }

    let(:scopes) { double }

    let(:token_type) { double }

    let(:character_id) { double }

    before { expect(subject).to receive(:character).and_return(character) }

    before { expect(subject).to receive(:name).and_return(name) }

    before { expect(subject).to receive(:access_token).and_return(access_token) }

    before { expect(subject).to receive(:refresh_token).and_return(refresh_token) }

    before { expect(subject).to receive(:token_expires_at).and_return(token_expires_at) }

    before { expect(subject).to receive(:token_expires).and_return(token_expires) }

    before { expect(subject).to receive(:scopes).and_return(scopes) }

    before { expect(subject).to receive(:token_type).and_return(token_type) }

    before { expect(subject).to receive(:character_id).and_return(character_id) }

    before do
      #
      # character.assign_attributes(name: name,
      #                             access_token: access_token,
      #                             refresh_token: refresh_token,
      #                             token_expires_at: token_expires_at,
      #                             token_expires: token_expires,
      #                             scopes: scopes,
      #                             token_type: token_type,
      #                             character_id: character_id,
      #                             esi_token_valid: true,
      #                             esi_token_invalid_at: nil,
      #                             esi_last_error: nil)
      #
      expect(character).to receive(:assign_attributes)
        .with({
          name: name,
          access_token: access_token,
          refresh_token: refresh_token,
          token_expires_at: token_expires_at,
          token_expires: token_expires,
          scopes: scopes,
          token_type: token_type,
          character_id: character_id,
          esi_token_valid: true,
          esi_token_invalid_at: nil,
          esi_last_error: nil
        })
    end

    specify { expect { subject.send(:assign_character_attributes) }.not_to raise_error }
  end

  describe "#remove_old_characters" do
    let(:character_id) { double }

    let(:character_owner_hash) { double }

    before { expect(subject).to receive(:character_id).and_return(character_id) }

    before { expect(subject).to receive(:character_owner_hash).and_return(character_owner_hash) }

    before do
      #
      # Character.where(character_id: character_id)
      #          .where.not(character_owner_hash: character_owner_hash)
      #          .destroy_all
      expect(Character).to receive(:where).with({character_id: character_id}) do
        double.tap do |a|
          expect(a).to receive(:where) do
            double.tap do |b|
              expect(b).to receive(:not).with({character_owner_hash: character_owner_hash}) do
                double.tap do |c|
                  expect(c).to receive(:destroy_all)
                end
              end
            end
          end
        end
      end
    end

    specify { expect { subject.send(:remove_old_characters) }.not_to raise_error }
  end

  describe "#update_character_info" do
    let(:character_id) { double }

    before { expect(subject).to receive(:character_id).and_return(character_id) }

    before do
      #
      # UpdateCharacterInfoService.new(character_id).execute
      #
      expect(UpdateCharacterInfoService).to receive(:new).with(character_id) do
        double.tap do |a|
          expect(a).to receive(:execute)
        end
      end
    end

    specify { expect { subject.send(:update_character_info) }.not_to raise_error }
  end

  describe "#import_corporation_members" do
    let(:character_id) { double }

    before { expect(subject).to receive(:character_id).and_return(character_id) }

    before do
      #
      # CorporationMembersJob.perform_later(character_id)
      #
      expect(CorporationMembersJob).to receive(:perform_later).with(character_id)
    end

    specify { expect { subject.send(:import_corporation_members) }.not_to raise_error }
  end

  describe "#import_missing_data" do
    before do
      #
      # ImportMissing::Everything.new.import
      #
      expect(ImportMissing::Everything).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.send(:import_missing_data) }.not_to raise_error }
  end
end
