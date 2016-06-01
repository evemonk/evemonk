require 'rails_helper'

describe Api::SessionsController do
  it { should be_a Api::BaseController }

  it { should_not use_before_action(:authenticate) }
end
