EvemonkApp.Collections.Characters = Backbone.PageableCollection.extend({
    url: Routes.api_characters_path(),
    model: EvemonkApp.Models.Character,

    state: {
        firstPage: 1,
        pageSize: 25
    },

    queryParams: {
        currentPage: 'page',
        totalPages: null,
        totalRecords: null,
        pageSize: null
    },

    parseState: function (response, queryParams, state, options) {
        return { currentPage: response.current_page,
            totalRecords: response.total_entries,
            totalPages: response.total_pages };
    },

    parseRecords: function (response, options) {
        return response.collection;
    }
});
