# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersCountNotifier do
  it { is_expected.to be_an(ApplicationNotifier) }
end
