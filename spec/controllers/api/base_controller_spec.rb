# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::BaseController do
  it { should be_a(ActionController::Base) }

  it { should use_before_action(:verify_requested_format!) }

  it { should rescue_from(ActiveRecord::RecordNotFound) }

  it { should rescue_from(ActionController::UnknownFormat) }
end
