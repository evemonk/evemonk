EvemonkApp.Views.CharacterView = Backbone.View.extend({
    events: {
        'click .destroy' : 'destroy'
    },

    template: JST['characters/show'],

    render: function () {
        this.$el.html(this.template(this.model.toJSON()));

        return this;
    },

    edit: function (event) {
        event.preventDefault();

        Backbone.history.navigate(event.target.getAttribute('href'), { trigger: true });
    },

    destroy: function (event) {
        event.preventDefault();

        if (confirm('Are you sure?') === true) {
            this.model.destroy();

            var flash = new EvemonkApp.Models.FlashSuccess({ message: 'Character successful removed.' });

            var flashView = new EvemonkApp.Views.FlashView({ model: flash });

            $('#flash').append(flashView.render().el);

            Backbone.history.navigate('characters', { trigger: true });
        } else {
            return false
        }
    }
});
