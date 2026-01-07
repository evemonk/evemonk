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

  specify do
    skip "Not implemented"

    expect(page).to have_link("Assets", href: Rails.application.routes.url_helpers.character_assets_path(character))
  end

  specify { expect(page).to have_link("Loyalty points", href: Rails.application.routes.url_helpers.character_loyalty_points_path(character)) }

  specify { expect(page).to have_link("Skills", href: Rails.application.routes.url_helpers.character_skills_path(character)) }

  specify do
    skip "Not implemented"

    expect(page).to have_link("Mail", href: Rails.application.routes.url_helpers.character_mails_path(character))
  end

  specify do
    skip "Not implemented"

    expect(page).to have_link("Standings", href: Rails.application.routes.url_helpers.character_standings_path(character))
  end

  specify do
    skip "Not implemented"

    expect(page).to have_link("Wallet journal", href: Rails.application.routes.url_helpers.character_wallet_journals_path(character))
  end

  specify do
    skip "Not implemented"

    expect(page).to have_link("Wallet transactions", href: "")
  end

  specify do
    skip "Not implemented"

    expect(page).to have_link("Industry Jobs", href: Rails.application.routes.url_helpers.character_industry_jobs_path(character))
  end

  specify { expect(page).to have_link("Blueprints", href: Rails.application.routes.url_helpers.character_blueprints_path(character)) }

  specify do
    skip "Not implemented"

    expect(page).to have_link("Manufacturing Jobs", href: Rails.application.routes.url_helpers.character_manufacturing_jobs_path(character))
  end

  specify do
    skip "Not implemented"

    expect(page).to have_link("Orders", href: Rails.application.routes.url_helpers.character_orders_path(character))
  end

  describe "Training Queue" do
    it "is expected to have training queue link" do
      Flipper.enable(:internal_training_queue_tab)

      render_inline(subject)

      expect(page).to have_link("Training Queue", href: Rails.application.routes.url_helpers.character_training_queues_path(character))
    end

    it "is expected not to have training queue link" do
      Flipper.disable(:internal_training_queue_tab)

      render_inline(subject)

      expect(page).to have_no_link("Training Queue", href: Rails.application.routes.url_helpers.character_training_queues_path(character))
    end
  end

  describe "Certificates" do
    it "is expected to have certificates link" do
      Flipper.enable(:internal_certificates_tab)

      render_inline(subject)

      expect(page).to have_link("Certificates", href: Rails.application.routes.url_helpers.character_certificates_path(character))
    end

    it "is expected not to have certificates link" do
      Flipper.disable(:internal_certificates_tab)

      render_inline(subject)

      expect(page).to have_no_link("Certificates", href: Rails.application.routes.url_helpers.character_certificates_path(character))
    end
  end

  specify { expect(page).to have_link("Settings", href: Rails.application.routes.url_helpers.character_settings_path(character)) }

  describe "Help" do
    it "is expected to have help link" do
      Flipper.enable(:internal_help_tab)

      render_inline(subject)

      expect(page).to have_link("Help", href: Rails.application.routes.url_helpers.character_helps_path(character))
    end

    it "is expected not to have help link" do
      Flipper.disable(:internal_help_tab)

      render_inline(subject)

      expect(page).to have_no_link("Help", href: Rails.application.routes.url_helpers.character_helps_path(character))
    end
  end
end
