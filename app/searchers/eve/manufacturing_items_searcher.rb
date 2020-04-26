# frozen_string_literal: true

module Eve
  class ManufacturingItemsSearcher
    attr_reader :query, :scope

    def initialize(query, scope = Eve::Type.all)
      @query = query
      @scope = scope
    end

    def search
      if query.present? && query.length > 2
        ids = Eve::Type.search(query, options).map(&:id)

        if ids.present?
          scope.where(id: ids)
        else
          Eve::Type.none
        end
      else
        scope.where(is_manufacturing_item: true)
      end
    end

    private

    def options
      {
        fields: [
          :name_en,
          :name_de,
          :name_fr,
          :name_ja,
          :name_ru,
          :name_zh,
          :name_ko],
        match: :word_start,
        where: {
          published: true,
          is_manufacturing_item: true
        },
        load: false,
        misspellings: {below: 5}
      }
    end
  end
end
