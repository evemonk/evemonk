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

  xspecify { expect(page).to have_link("Mail", href: Rails.application.routes.url_helpers.character_mails_path(character)) }

  xspecify { expect(page).to have_link("Standings", href: Rails.application.routes.url_helpers.character_standings_path(character)) }

  xspecify { expect(page).to have_link("Wallet journal", href: Rails.application.routes.url_helpers.character_wallet_journals_path(character)) }

  xspecify { expect(page).to have_link("Wallet transactions", href: "") }

  xspecify { expect(page).to have_link("Industry Jobs", href: Rails.application.routes.url_helpers.character_industry_jobs_path(character)) }

  specify { expect(page).to have_link("Blueprints", href: Rails.application.routes.url_helpers.character_blueprints_path(character)) }

  xspecify { expect(page).to have_link("Manufacturing Jobs", href: Rails.application.routes.url_helpers.character_manufacturing_jobs_path(character)) }

  xspecify { expect(page).to have_link("Orders", href: Rails.application.routes.url_helpers.character_orders_path(character)) }

  specify { expect(page).to have_link("Training Queue", href: Rails.application.routes.url_helpers.character_training_queues_path(character)) }

  specify { expect(page).to have_link("Certificates", href: Rails.application.routes.url_helpers.character_certificates_path(character)) }

  specify { expect(page).to have_link("Settings", href: Rails.application.routes.url_helpers.character_settings_path(character)) }
end
