# frozen_string_literal: true

require "rails_helper"

describe FooterComponent, type: :component do
  it "should have link to FAQ" do
    render_inline(described_class.new)

    expect(page).to have_link("FAQ", href: "/faq")
  end

  it "should have link to privacy policy" do
    render_inline(described_class.new)

    expect(page).to have_link("Privacy policy", href: "/privacy_policy")
  end

  it "should have link to terms of use" do
    render_inline(described_class.new)

    expect(page).to have_link("Terms of use", href: "/terms_of_service")
  end

  it "should have link to about" do
    render_inline(described_class.new)

    expect(page).to have_link("About", href: "/about")
  end

  it "should have link to GraphQL" do
    render_inline(described_class.new)

    expect(page).to have_link("GraphQL", href: "/graphiql", target: "_blank")
  end

  it "should have link to blog" do
    render_inline(described_class.new)

    expect(page).to have_link("Blog", href: "https://blog.evemonk.com", target: "_blank")
  end

  it "should have link to GitHub repo" do
    render_inline(described_class.new)

    expect(page).to have_link("GitHub", href: "https://github.com/evemonk/evemonk", target: "_blank")
  end

  it "should have link to SDE Archive" do
    render_inline(described_class.new)

    expect(page).to have_link("SDE Archive", href: "https://sde.evemonk.com/", target: "_blank")
  end

  it "should have copyright" do
    render_inline(described_class.new)

    expect(page).to have_text("© 2016 — 2023 EveMonk")
  end
end
