# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::BaseController do
  it { expect(subject).to be_a(ActionController::Base) }

  it { expect(subject).to use_before_action(:verify_requested_format!) }

  it { expect(subject).to rescue_from(ActiveRecord::RecordNotFound) }

  it { expect(subject).to rescue_from(ActionController::UnknownFormat) }
end
