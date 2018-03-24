EvemonkApp.Views.AllianceView = Backbone.View.extend({
    tagName: 'td',
    attributes: { colspan: '2' },

    template: JST['alliances/show'],

    render: function () {
        this.$el.html(this.template(this.model.toJSON()));

        return this;
    }
});
