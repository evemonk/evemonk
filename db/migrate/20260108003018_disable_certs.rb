# frozen_string_literal: true

class DisableCerts < ActiveRecord::Migration[8.1]
  def change
    # Disable internal certificates tab for character
    Flipper.disable :internal_certificates_tab

    # Disable internal training queue tab for character
    Flipper.disable :internal_training_queue_tab

    # Disable internal help tab for character
    Flipper.disable :internal_help_tab
  end
end
