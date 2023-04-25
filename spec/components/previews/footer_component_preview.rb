# frozen_string_literal: true

class FooterComponentPreview < Lookbook::Preview
  def default
    render FooterComponent.new
  end
end
