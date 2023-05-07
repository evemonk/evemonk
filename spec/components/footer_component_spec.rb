# frozen_string_literal: true

require "rails_helper"

describe FooterComponent, type: :component do
  it { should be_an(ApplicationComponent) }

  before { render_inline(subject) }

  specify { expect(page).to have_link("FAQ", href: "/faq") }

  specify { expect(page).to have_link("Privacy policy", href: "/privacy_policy") }

  specify { expect(page).to have_link("Terms of use", href: "/terms_of_service") }

  specify { expect(page).to have_link("About", href: "/about") }

  specify { expect(page).to have_link("GraphQL", href: "/graphiql", target: "_blank") }

  specify { expect(page).to have_link("Blog", href: "https://blog.evemonk.com", target: "_blank") }

  specify { expect(page).to have_link("GitHub", href: "https://github.com/evemonk/evemonk", target: "_blank") }

  specify { expect(page).to have_link("SDE Archive", href: "https://sde.evemonk.com/", target: "_blank") }

  specify { expect(page).to have_text("© 2016 — 2023 EveMonk") }
end
