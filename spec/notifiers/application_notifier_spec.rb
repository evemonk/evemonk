# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationNotifier do
  it { should be_a(Noticed::Event) }
end
