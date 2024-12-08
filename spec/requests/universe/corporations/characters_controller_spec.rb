# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::Corporations::CharactersController do
  it { expect(subject).to be_a(ApplicationController) }

  # describe "#index" do
  #   let(:eve_corporation) { instance_double(Eve::Corporation) }
  #
  #   before do
  #     #
  #     # Eve::Corporation.find(params[:corporation_id]) # => eve_corporation
  #     #
  #     expect(Eve::Corporation).to receive(:find).with("1000001").and_return(eve_corporation)
  #   end
  #
  #   before do
  #     #
  #     # Eve::Character
  #     #   .where(corporation: @corporation)
  #     #   .order(:name)
  #     #
  #     expect(Eve::Character).to receive(:where).with(corporation: eve_corporation) do
  #       double.tap do |a|
  #         expect(a).to receive(:order).with(:name)
  #       end
  #     end
  #   end
  #
  #   before { get :index, params: {corporation_id: "1000001"} }
  #
  #   it { expect(subject).to respond_with(:ok) }
  #
  #   it { expect(subject).not_to render_with_layout }
  #
  #   it { expect(subject).to render_template(:index) }
  # end
end
