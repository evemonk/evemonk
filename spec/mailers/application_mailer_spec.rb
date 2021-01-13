# frozen_string_literal: true

require "rails_helper"

describe ApplicationMailer do
  it { expect(subject.default_params[:from]).to eq("EveMonk <robot@evemonk.com>") }

  it { expect(described_class._layout).to eq("mailer") }
end
