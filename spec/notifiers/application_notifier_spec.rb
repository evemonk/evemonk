# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationNotifier do
  it { is_expected.to be_a(Noticed::Event) }
end
