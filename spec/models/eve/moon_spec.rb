require "rails_helper"

describe Eve::Moon do
  it { should be_a(ApplicationRecord) }

  it { should respond_to(:versions) }
end
