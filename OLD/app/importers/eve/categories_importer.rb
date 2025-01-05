# frozen_string_literal: true

module Eve
  class CategoriesImporter < BaseImporter
    def import
      import! do
        import_new_categories

        remove_old_categories
      end
    end

    private

    def esi
      @esi ||= EveOnline::ESI::UniverseCategories.new
    end

    def import_new_categories
      eve_category_ids = Eve::Category.ids

      categories_ids_to_create = esi.category_ids - eve_category_ids

      jobs = categories_ids_to_create.map { |category_id| Eve::UpdateCategoryJob.new(category_id) }

      ActiveJob.perform_all_later(jobs)
    end

    def remove_old_categories
      eve_categories_ids = Eve::Category.ids

      categories_ids_to_remove = eve_categories_ids - esi.category_ids

      categories_ids_to_remove.each do |category_id|
        eve_category = Eve::Category.find_or_initialize_by(id: category_id)

        eve_category.destroy!
      end
    end
  end
end
