# frozen_string_literal: true

require 'rails_helper'

module Api
  describe SessionsController do
    it { should be_a(Api::BaseController) }

    it { should use_before_action(:authenticate!) }
  end
end
