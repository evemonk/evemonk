# frozen_string_literal: true

module Sde
  class CertificatesJob < ApplicationJob
    queue_as :default

    def perform(file)
      CertificatesImporter.new(file).import
    end
  end
end
