# frozen_string_literal: true

if defined? Prosopite
  Prosopite.raise = true
  Prosopite.rails_logger = true
  Prosopite.prosopite_logger = true
  Prosopite.ignore_queries = [/regex_match/, "SELECT var, value FROM \"settings\""]
end
