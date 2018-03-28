EvemonkApp.Views.CorporationView = Backbone.View.extend({
    tagName: 'td',
    attributes: { colspan: '2' },

    template: JST['corporations/show'],

    render: function () {
        this.$el.html(this.template(this.model.toJSON()));

        return this;
    }
});
