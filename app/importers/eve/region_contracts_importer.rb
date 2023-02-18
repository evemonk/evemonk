# frozen_string_literal: true

module Eve
  class RegionContractsImporter < BaseImporter
    attr_reader :region_id, :page

    def initialize(region_id, page)
      @region_id = region_id
      @page = page
    end

    def import
      import! do
        remove_all_region_contracts

        import_new_contracts

        import_other_pages
      end
    end

    def esi
      @esi ||= EveOnline::ESI::PublicContracts.new(region_id: region_id, page: page)
    end

    private

    def region
      @region ||= Eve::Region.find(region_id)
    end

    def remove_all_region_contracts
      region.contracts.destroy_all
    end

    def import_new_contracts
      esi.contracts.each do |contract|
        region.contracts.create!(contract.as_json)
      end
    end

    def import_other_pages
      return if page != 1 || esi.total_pages == 1

      (2..esi.total_pages).each do |next_page|
        Eve::RegionContractsJob.perform_later(region_id, next_page)
      end
    end
  end
end
