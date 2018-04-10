# frozen_string_literal: true

VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join('spec', 'cassettes')
  c.hook_into :webmock
  c.ignore_localhost = true
end
