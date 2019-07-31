# frozen_string_literal: true

# :nocov:
module Api
  module Docs
    module Shared
      module NotFound
        def self.extended(base)
          base.response "404" do
            key :description, "Not Found"
          end
        end
      end
    end
  end
end
# :nocov:
