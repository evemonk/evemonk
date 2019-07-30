# frozen_string_literal: true

# :nocov:
module Api
  module Docs
    module Shared
      module NotAcceptable
        def self.extended(base)
          base.response "406" do
            key :description, "Not Acceptable. The target resource does not have a current representation that would be acceptable to the user agent."
          end
        end
      end
    end
  end
end
# :nocov:
