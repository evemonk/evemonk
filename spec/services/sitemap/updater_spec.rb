# frozen_string_literal: true

require 'rails_helper'

describe Sitemap::Updater do
  describe '#update' do
    before { expect(SitemapGenerator::Interpreter).to receive(:run).with(verbose: false) }

    before { expect(FileUtils).to receive(:mkdir_p).with('/shared') }

    let(:glob1) { double }

    before { expect(Dir).to receive(:glob).with('/shared/*.xml.gz').and_return(glob1) }

    before { expect(FileUtils).to receive(:rm).with(glob1) }

    let(:glob2) { double }

    before { expect(Dir).to receive(:glob).with('public/*.xml.gz').and_return(glob2) }

    before { expect(FileUtils).to receive(:cp).with(glob2, '/shared') }

    before { expect(SitemapGenerator::Sitemap).to receive(:ping_search_engines) }

    specify { expect { subject.update }.not_to raise_error }
  end
end
