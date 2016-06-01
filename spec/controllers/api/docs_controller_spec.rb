require 'rails_helper'

describe Api::DocsController do
  it { should be_a ActionController::Base }

  it { should be_a Swagger::Blocks }
end
