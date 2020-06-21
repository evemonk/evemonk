# frozen_string_literal: true

module Eve
  class RegionContractsImporter
    attr_reader :region_id, :page

    def initialize(region_id, page)
      @region_id = region_id
      @page = page
    end

    def import
    end

    # def import
    #   ActiveRecord::Base.transaction do
    #     esi = EveOnline::ESI::PublicContracts.new(region_id: region_id,
    #                                               page: page)
    #
    #     etag = Eve::Etag.find_or_initialize_by(url: esi.url)
    #
    #     esi.etag = etag.etag
    #
    #     return if esi.not_modified?
    #
    #     remove_all_contracts
    #
    #     import_new_contracts(esi)
    #
    #     import_other_pages
    #
    #     etag.update!(etag: esi.etag, body: esi.response)
    #   end
    # end
    #
    # private
    #
    # def region
    #   @region ||= Eve::Region.find_by!(region_id: region_id)
    # end
    #
    # def remove_all_contracts
    #   region.contracts.destroy_all
    # end
    #
    # def import_new_contracts(esi)
    #   esi.contracts.each do |contract|
    #     region.contracts.create!(contract.as_json)
    #   end
    # end
    #
    # def import_other_pages
    #
    # end
  end
end
