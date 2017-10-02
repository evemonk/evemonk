EvemonkApp.Views.CharactersView = Backbone.View.extend({
    events: {
        'click .change-page': 'change_page'
    },

    template: JST['characters/index'],

    initialize: function () {
        this.listenTo(this.collection, 'remove', this.render);
        this.listenTo(this.collection, 'reset', this.render);
    },

    render: function () {
        this.$el.html(this.template(this.collection));

        var tbody = this.$('#characters_tbody');

        this.collection.each(function (model) {
            var characterRowView = new EvemonkApp.Views.CharacterRowView({ model: model });

            tbody.append(characterRowView.render().el);
        });

        return this;
    },

    change_page: function (event) {
        event.preventDefault();

        var page = parseInt(event.target.text);

        var self = this;

        this.collection.getPage(page, {
            fetch: true,
            reset: true,

            success: function () {
                Backbone.history.navigate('characters?page=' + page);
            },
            error: function (model, response, options) {
                if (response.status === 401) {
                    self.unauthorized();
                }
            }
        });
    }
});
