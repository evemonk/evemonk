# frozen_string_literal: true

module Eve
  class CategoriesImporter
    def import
      ActiveRecord::Base.transaction do
        esi = EveOnline::ESI::UniverseCategories.new

        etag = Eve::Etag.find_or_initialize_by(url: esi.url)

        esi.etag = etag.etag

        return if esi.not_modified?

        import_new_categories(esi)

        remove_old_categories(esi)

        etag.update!(etag: esi.etag, body: esi.response)
      end
    end

    def import_new_categories(esi)
      eve_category_ids = Eve::Category.pluck(:category_id)

      categories_ids_to_create = esi.category_ids - eve_category_ids

      categories_ids_to_create.each do |category_id|
        Eve::UpdateCategoryJob.perform_later(category_id)
      end
    end

    def remove_old_categories(esi)
      eve_categories_ids = Eve::Category.pluck(:category_id)

      categories_ids_to_remove = eve_categories_ids - esi.category_ids

      categories_ids_to_remove.each do |category_id|
        eve_category = Eve::Category.find_or_initialize_by(category_id: category_id)

        eve_category.destroy!
      end
    end
  end
end
