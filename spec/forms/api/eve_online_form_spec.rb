# frozen_string_literal: true

require "rails_helper"

describe Api::EveOnlineForm do
  let(:request) { double }

  subject(:form) { described_class.new(request) }

  describe "#initialize" do
    its(:request) { should eq(request) }
  end

  describe "#save!" do
    before { expect(form).to receive(:assign_character_attributes) }

    before { expect(form).to receive(:build_user) }

    before { expect(form).to receive(:remove_old_characters) }

    let(:character) { instance_double(Character) }

    before { expect(form).to receive(:character).and_return(character) }

    before { expect(character).to receive(:save!) }

    let(:session) { instance_double(Session) }

    before { expect(form).to receive(:session).and_return(session) }

    before { expect(session).to receive(:save!) }

    before { expect(form).to receive(:update_character_info) }

    specify { expect { form.save! }.not_to raise_error }
  end

  describe "#session" do
    context "when @session is set" do
      let(:session) { instance_double(Session) }

      before { form.instance_variable_set(:@session, session) }

      specify { expect(form.session).to eq(session) }
    end

    context "when @session not set" do
      let(:session) { instance_double(Session) }

      let(:character) { instance_double(Character) }

      before { expect(form).to receive(:character).and_return(character) }

      before do
        #
        # character.user.sessions.build # => session
        #
        expect(character).to receive(:user) do
          double.tap do |a|
            expect(a).to receive(:sessions) do
              double.tap do |b|
                expect(b).to receive(:build).and_return(session)
              end
            end
          end
        end
      end

      specify { expect(form.session).to eq(session) }

      specify { expect { form.session }.to change { form.instance_variable_get(:@session) }.from(nil).to(session) }
    end
  end

  # private methods

  describe "#character_id" do
    before do
      #
      # request.env.dig('omniauth.auth', 'info', 'character_id')
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with("omniauth.auth", "info", "character_id")
        end
      end
    end

    specify { expect { form.send(:character_id) }.not_to raise_error }
  end

  describe "#name" do
    before do
      #
      # request.env.dig('omniauth.auth', 'info', 'name')
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with("omniauth.auth", "info", "name")
        end
      end
    end

    specify { expect { form.send(:name) }.not_to raise_error }
  end

  describe "#access_token" do
    before do
      #
      # request.env.dig('omniauth.auth', 'credentials', 'token')
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with("omniauth.auth", "credentials", "token")
        end
      end
    end

    specify { expect { form.send(:access_token) }.not_to raise_error }
  end

  describe "#refresh_token" do
    before do
      #
      # request.env.dig('omniauth.auth', 'credentials', 'refresh_token')
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with("omniauth.auth", "credentials", "refresh_token")
        end
      end
    end

    specify { expect { form.send(:refresh_token) }.not_to raise_error }
  end

  describe "#token_expires_at" do
    let(:expires_at) { double }

    before do
      #
      # request.env.dig('omniauth.auth', 'credentials', 'expires_at')
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

    specify { expect { form.send(:token_expires_at) }.not_to raise_error }
  end

  describe "#token_expires" do
    before do
      #
      # request.env.dig('omniauth.auth', 'credentials', 'expires')
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with("omniauth.auth", "credentials", "expires")
        end
      end
    end

    specify { expect { form.send(:token_expires) }.not_to raise_error }
  end

  describe "#scopes" do
    before do
      #
      # request.env.dig('omniauth.auth', 'info', 'scopes')
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with("omniauth.auth", "info", "scopes")
        end
      end
    end

    specify { expect { form.send(:scopes) }.not_to raise_error }
  end

  describe "#token_type" do
    before do
      #
      # request.env.dig('omniauth.auth', 'info', 'token_type')
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with("omniauth.auth", "info", "token_type")
        end
      end
    end

    specify { expect { form.send(:token_type) }.not_to raise_error }
  end

  describe "#character_owner_hash" do
    before do
      #
      # request.env.dig('omniauth.auth', 'info', 'character_owner_hash')
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with("omniauth.auth", "info", "character_owner_hash")
        end
      end
    end

    specify { expect { form.send(:character_owner_hash) }.not_to raise_error }
  end

  describe "#character" do
    context "when @character is set" do
      let(:character) { instance_double(Character) }

      before { form.instance_variable_set(:@character, character) }

      specify { expect(form.send(:character)).to eq(character) }
    end

    context "when @character not set" do
      let(:character) { instance_double(Character) }

      let(:character_owner_hash) { double }

      before { expect(form).to receive(:character_owner_hash).and_return(character_owner_hash) }

      before { expect(Character).to receive(:find_or_initialize_by).with(character_owner_hash: character_owner_hash).and_return(character) }

      specify { expect(form.send(:character)).to eq(character) }

      specify { expect { form.send(:character) }.to change { form.instance_variable_get(:@character) }.from(nil).to(character) }
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

    before { expect(form).to receive(:character).and_return(character) }

    before { expect(form).to receive(:name).and_return(name) }

    before { expect(form).to receive(:access_token).and_return(access_token) }

    before { expect(form).to receive(:refresh_token).and_return(refresh_token) }

    before { expect(form).to receive(:token_expires_at).and_return(token_expires_at) }

    before { expect(form).to receive(:token_expires).and_return(token_expires) }

    before { expect(form).to receive(:scopes).and_return(scopes) }

    before { expect(form).to receive(:token_type).and_return(token_type) }

    before { expect(form).to receive(:character_id).and_return(character_id) }

    before do
      #
      # character.assign_attributes(name: name,
      #                             access_token: access_token,
      #                             refresh_token: refresh_token,
      #                             token_expires_at: token_expires_at,
      #                             token_expires: token_expires,
      #                             scopes: scopes,
      #                             token_type: token_type,
      #                             character_id: character_id)
      #
      expect(character).to receive(:assign_attributes).with(name: name,
                                                            access_token: access_token,
                                                            refresh_token: refresh_token,
                                                            token_expires_at: token_expires_at,
                                                            token_expires: token_expires,
                                                            scopes: scopes,
                                                            token_type: token_type,
                                                            character_id: character_id)
    end

    specify { expect { form.send(:assign_character_attributes) }.not_to raise_error }
  end

  describe "#build_user" do
    context "when user not set in character" do
      let(:character) { instance_double(Character, user: nil) }

      before { expect(form).to receive(:character).and_return(character).twice }

      before { expect(character).to receive(:build_user).with(kind: :oauth) }

      specify { expect { form.send(:build_user) }.not_to raise_error }
    end

    context "when user is set in character" do
      let(:user) { instance_double(User) }

      let(:character) { instance_double(Character, user: user) }

      before { expect(form).to receive(:character).and_return(character) }

      before { expect(character).not_to receive(:build_user) }

      specify { expect { form.send(:build_user) }.not_to raise_error }
    end
  end

  describe "#remove_old_characters" do
    context "when character is new record, remove old characters" do
      let(:character_id) { double }

      let(:character) { instance_double(Character, new_record?: true) }

      before { expect(form).to receive(:character_id).and_return(character_id) }

      before { expect(form).to receive(:character).and_return(character) }

      before do
        #
        # Character.where(character_id: character_id).destroy_all
        #
        expect(Character).to receive(:where).with(character_id: character_id) do
          double.tap do |a|
            expect(a).to receive(:destroy_all)
          end
        end
      end

      specify { expect { form.send(:remove_old_characters) }.not_to raise_error }
    end

    context "when character is not new record" do
      let(:character) { instance_double(Character, new_record?: false) }

      before { expect(form).to receive(:character).and_return(character) }

      before { expect(Character).not_to receive(:where) }

      specify { expect { form.send(:remove_old_characters) }.not_to raise_error }
    end
  end

  describe "#update_character_info" do
    let(:character) { instance_double(Character) }

    before { expect(form).to receive(:character).and_return(character) }

    before do
      #
      # Api::UpdateCharacterInfo.new(character).update!
      #
      expect(Api::UpdateCharacterInfo).to receive(:new).with(character) do
        double.tap do |a|
          expect(a).to receive(:update!)
        end
      end
    end

    specify { expect { form.send(:update_character_info) }.not_to raise_error }
  end
end
