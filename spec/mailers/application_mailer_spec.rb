# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationMailer do
  before { ENV["ACTION_MAILER_FROM"] = "EveMonk <robot@evemonk.com>" }

  after { ENV.delete("ACTION_MAILER_FROM") }

  it { expect(subject.default_params[:from]).to eq("EveMonk <robot@evemonk.com>") }

  it { expect(described_class._layout).to eq("mailer") }
end
