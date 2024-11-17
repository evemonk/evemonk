# frozen_string_literal: true

require "rails_helper"

RSpec.describe CharacterNavBarComponent, type: :component do
  subject { described_class.new(character, "sheet") }

  it { expect(subject).to be_an(ApplicationComponent) }

  let(:character) { build_stubbed(:character) }

  before { render_inline(subject) }

  specify { expect(page).to have_link("Sheet", href: Rails.application.routes.url_helpers.character_path(character)) }

  specify { expect(page).to have_link("Employment History", href: Rails.application.routes.url_helpers.character_employment_histories_path(character)) }

  specify { expect(page).to have_link("Agents", href: Rails.application.routes.url_helpers.character_agents_path(character)) }

  xspecify { expect(page).to have_link("Assets", href: Rails.application.routes.url_helpers.character_assets_path(character)) }

  specify { expect(page).to have_link("Loyalty points", href: Rails.application.routes.url_helpers.character_loyalty_points_path(character)) }

  specify { expect(page).to have_link("Skills", href: Rails.application.routes.url_helpers.character_skills_path(character)) }
# <%= link_to("Mail", character_mails_path(@character), class: "nav-link active") %>
# <%= link_to("Standings", character_standings_path(@character), class: "nav-link active") %>
# <%= link_to("Wallet journal", character_wallet_journals_path(@character), class: "nav-link active") %>
# <%= link_to("Wallet transactions", nil, class: "nav-link active") %>
# <%= link_to("Industry Jobs", character_industry_jobs_path(@character), class: "nav-link active") %>
# <%= link_to("Blueprints", character_blueprints_path(@character), class: "nav-link active") %>
# <%= link_to("Manufacturing Jobs", character_manufacturing_jobs_path(@character), class: "nav-link active") %>
# <%= link_to("Orders", character_orders_path(@character), class: "nav-link active") %>
# <%= link_to("Training Queue", character_training_queues_path(@character), class: "nav-link active") %>
# <%= link_to("Certificates", character_certificates_path(@character), class: "nav-link active") %>
# <%= link_to("Settings", character_settings_path(@character), class: "nav-link active") %>
end
