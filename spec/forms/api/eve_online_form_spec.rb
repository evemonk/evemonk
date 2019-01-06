# frozen_string_literal: true

require 'rails_helper'

describe Api::EveOnlineForm do
  let(:request) { double }

  subject { described_class.new(request) }

  describe '#initialize' do
    its(:request) { should eq(request) }
  end

  describe '#save!' do
    specify { expect { subject.save! }.not_to raise_error }
  end

  # private methods

  describe '#character_id' do
    before do
      #
      # request.env.dig('omniauth.auth', 'info', 'character_id')
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with('omniauth.auth', 'info', 'character_id')
        end
      end
    end

    specify { expect { subject.send(:character_id) }.not_to raise_error }
  end

  describe '#name' do
    before do
      #
      # request.env.dig('omniauth.auth', 'info', 'name')
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with('omniauth.auth', 'info', 'name')
        end
      end
    end

    specify { expect { subject.send(:name) }.not_to raise_error }
  end

  describe '#access_token' do
    before do
      #
      # request.env.dig('omniauth.auth', 'credentials', 'token')
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with('omniauth.auth', 'credentials', 'token')
        end
      end
    end

    specify { expect { subject.send(:access_token) }.not_to raise_error }
  end

  describe '#refresh_token' do
    before do
      #
      # request.env.dig('omniauth.auth', 'credentials', 'refresh_token')
      #
      expect(request).to receive(:env) do
        double.tap do |a|
          expect(a).to receive(:dig).with('omniauth.auth', 'credentials', 'refresh_token')
        end
      end
    end

    specify { expect { subject.send(:refresh_token) }.not_to raise_error }
  end

  # def token_expires_at
  #   Time.zone.at(request.env.dig('omniauth.auth', 'credentials', 'expires_at'))
  # end

  # def token_expires
  #   request.env.dig('omniauth.auth', 'credentials', 'expires')
  # end

  # def scopes
  #   request.env.dig('omniauth.auth', 'info', 'scopes')
  # end

  # def token_type
  #   request.env.dig('omniauth.auth', 'info', 'token_type')
  # end

  # def character_owner_hash
  #   request.env.dig('omniauth.auth', 'info', 'character_owner_hash')
  # end

  describe '#character' do
    context 'when @character is set' do
      let(:character) { instance_double(Character) }

      before { subject.instance_variable_set(:@character, character) }

      specify { expect(subject.send(:character)).to eq(character) }
    end

    context 'when @character not set' do
      let(:character) { instance_double(Character) }

      let(:character_id) { double }

      before { expect(subject).to receive(:character_id).and_return(character_id) }

      before { expect(Character).to receive(:find_or_initialize_by).with(character_id: character_id).and_return(character) }

      specify { expect(subject.send(:character)).to eq(character) }

      specify { expect { subject.send(:character) }.to change { subject.instance_variable_get(:@character) }.from(nil).to(character) }
    end
  end
end
