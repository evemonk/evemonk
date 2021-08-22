# frozen_string_literal: true

module ImportMissing
  class ForDevelopment
    def import
      Rails.logger.info "Import eve races"
      Eve::UpdateRacesJob.perform_later
    end
  end
end
