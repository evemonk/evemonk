# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersCountNotifier do
  it { expect(subject).to be_an(ApplicationNotifier) }
end
