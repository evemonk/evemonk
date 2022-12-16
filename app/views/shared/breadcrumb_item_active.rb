# frozen_string_literal: true

module Views
  module Shared
    class BreadcrumbItemActive < Phlex::HTML
      def initialize(text:)
        @text = text
      end

      def template
        li(class: "breadcrumb-item active", aria: {current: "page"}) { @text }
      end
    end
  end
end
