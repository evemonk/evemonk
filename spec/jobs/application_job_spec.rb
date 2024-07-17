# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationJob do
  it { is_expected.to be_an(ActiveJob::Base) }
end
