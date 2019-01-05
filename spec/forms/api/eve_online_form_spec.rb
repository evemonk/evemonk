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
end
