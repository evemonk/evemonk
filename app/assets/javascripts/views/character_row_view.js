EvemonkApp.Views.CharacterRowView = Backbone.View.extend({
    tagName: 'tr',

    events: {
        'click .show' : 'show',
        'click .destroy' : 'destroy'
    },

    template: JST['characters/character_row'],

    render: function () {
        this.$el.html(this.template(this.model.toJSON()));

        return this;
    },

    show: function (event) {
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
        } else {
            return false;
        }
    }
});
