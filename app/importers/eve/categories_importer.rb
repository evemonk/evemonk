# frozen_string_literal: true

module Eve
  class CategoriesImporter < BaseImporter
    def import
      import! do
        import_new_categories

        remove_old_categories
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseCategories.new
    end

    private

    def import_new_categories
      eve_category_ids = Eve::Category.pluck(:category_id)

      categories_ids_to_create = esi.category_ids - eve_category_ids

      categories_ids_to_create.each do |category_id|
        Eve::UpdateCategoryJob.perform_later(category_id)
      end
    end

    def remove_old_categories
      eve_categories_ids = Eve::Category.pluck(:category_id)

      categories_ids_to_remove = eve_categories_ids - esi.category_ids

      categories_ids_to_remove.each do |category_id|
        eve_category = Eve::Category.find_or_initialize_by(category_id: category_id)

        eve_category.destroy!
      end
    end
  end
end
