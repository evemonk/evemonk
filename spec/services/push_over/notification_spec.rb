# frozen_string_literal: true

require "rails_helper"

describe PushOver::Notification do
  specify { expect(described_class::API_URL).to eq("https://api.pushover.net") }

  specify { expect(described_class::PATH).to eq("/1/messages.json") }

  describe "#initialize" do
    context "without title" do
      subject do
        described_class.new("app-token",
          "user-token",
          "message")
      end

      its(:app_token) { should eq("app-token") }

      its(:user_key) { should eq("user-token") }

      its(:message) { should eq("message") }

      its(:title) { should eq("") }
    end

    context "with title" do
      subject do
        described_class.new("app-token",
          "user-token",
          "message",
          title: "title")
      end

      its(:app_token) { should eq("app-token") }

      its(:user_key) { should eq("user-token") }

      its(:message) { should eq("message") }

      its(:title) { should eq("title") }
    end
  end

  describe "#notify" do
    subject { described_class.new("", "", "") }

    let(:connection) { instance_double(Faraday::Connection) }

    before { expect(subject).to receive(:connection).and_return(connection) }

    let(:data) { double }

    before { expect(subject).to receive(:data).and_return(data) }

    before { expect(connection).to receive(:post).with(described_class::PATH, data.to_json) }

    specify { expect { subject.notify }.not_to raise_error }
  end

  # private methods

  describe "#data" do
    subject do
      described_class.new("app-token",
        "user-token",
        "message",
        title: "title")
    end

    specify do
      expect(subject.send(:data)).to eq(token: "app-token",
        user: "user-token",
        title: "title",
        message: "message")
    end
  end

  describe "#connection" do
    subject { described_class.new("", "", "") }

    before do
      #
      # Faraday.new(url: API_URL, headers: {"Content-Type": "application/json"})
      #
      expect(Faraday).to receive(:new).with(url: described_class::API_URL,
        headers: {"Content-Type": "application/json"})
    end

    specify { expect { subject.send(:connection) }.not_to raise_error }
  end
end
